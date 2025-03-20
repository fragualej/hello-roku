sub init()
    m.constants = constantsUtil_get()
    m.jobs = {}
    m.port = createObject("roMessagePort")
    m.top.observeField("request", m.port)
    m.top.functionName = "initHttpTask"
end sub

sub initHttpTask()
    while (true)
        msg = wait(0, m.port)
        if type(msg) = "roSGNodeEvent"
            handleRequest(msg)
        else if type(msg) = "roUrlEvent"
            handleResponse(msg)
        end if
    end while
end sub

sub handleRequest(event as object)
    request = event.getData()

    job = createObject("roUrlTransfer")
    job.setUrl(request.url)
    job.setHeaders(request.headers)
    job.setCertificatesFile("common:/certs/ca-bundle.crt")
    job.initClientCertificates()
    job.setMessagePort(m.port)
    job.asyncGetToString()

    requestId = job.getIdentity().toStr()
    m.jobs[requestId] = { job: job, request: request }
end sub

sub handleResponse(event as object)
    code = event.getResponseCode()
    requestId = event.getSourceIdentity().toStr()

    if (code >= 200 and code < 300)
        job = m.jobs[requestId].job
        request = m.jobs[requestId].request
        if job <> invalid
            print "[DEBUG] HTTPTask - Success: ", "id: " requestId, "status: " code, "url: " request.url
            body = event.getString()
            data = parseJson(body)
            content = buildResponse(request.model, data)
            request.httpNode.response = {
                status: code,
                content: content
            }
        end if
    else
        print "[DEBUG] HTTPTask - Error: ", code, requestId, formatJson(request)
    end if
end sub

function buildResponse(model as string, data as object)
    content = createObject("roSGNode", "contentNode")
    if model = "genres"
        genres = data.genres
        rowContent = content.createChild("contentNode")
        rowContent.addFields({ genres: genres })
        for i = 0 to 6
            genre = genres[i]
            itemContent = rowContent.createChild(model)
            itemContent.genreId = genre.id
            itemContent.genreName = genre.name
        end for
    else if model = "movies"
        results = data.results
        for i = 0 to data.results.count() - 1
            result = results[i]
            itemContent = content.createChild("movies")
            if result <> invalid
                itemContent.id = result.id
                itemContent.title = result.title
                itemContent.description = result.overview
                itemContent.popularity = result.popularity.toStr()
                itemContent.releaseDate = left(result.release_date, 4)
                itemContent.voteAverage = left(result.vote_average.toStr(), 3)
                itemContent.originalLanguage = result.original_language
                itemContent.genresIds = result.genre_ids

                posterUrlPortrait = ""
                posterUrlLandscape = ""

                if result.poster_path <> invalid and result.poster_path <> "" then posterUrlPortrait = result.poster_path
                if result.backdrop_path <> invalid and result.backdrop_path <> "" then posterUrlLandscape = result.backdrop_path

                itemContent.posterUrlPortrait = m.constants.api.TMDB_API_IMAGE_URL + posterUrlPortrait
                itemContent.posterUrlLandscape = m.constants.api.TMDB_API_IMAGE_URL + posterUrlLandscape
            end if
        end for
    end if
    return content
end function

