sub init()
    m.constants = {
        baseUrl: "https://api.themoviedb.org/3/trending/movie/week?api_key="
        imageUrl: "https://image.tmdb.org/t/p/w500"
        apiKey: "558e2410c2be44f6e971c2b2c8cf64d0"
    }

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
    if model = "genresModel"
        genres = data.genres
        rowContent = content.createChild("contentNode")
        rowContent.addFields({ genres: genres })
        for i = 0 to 6
            genre = genres[i]
            itemContent = rowContent.createChild(model)
            itemContent.genreId = genre.id
            itemContent.genreName = genre.name
            itemContent.genres = genres
        end for
    else if model = "moviesModel"
        results = data.results
        print "results", results.count()
        rows = 4
        cols = 5
        for j = 0 to rows - 1
            rowContent = content.createChild("contentNode")
            for i = 0 to cols - 1
                idx = j * cols + i
                result = results[idx]
                itemContent = rowContent.createChild(model)
                itemContent.id = result.id
                itemContent.title = result.title
                itemContent.description = result.overview
                itemContent.popularity = result.popularity.toStr()
                itemContent.releaseDate = left(result.release_date, 4)
                itemContent.voteAverage = left(result.vote_average.toStr(), 3)
                itemContent.originalLanguage = result.original_language

                if result.poster_path <> invalid and result.poster_path <> "" then posterUrlPortrait = result.poster_path
                if result.backdrop_path <> invalid and result.backdrop_path <> "" then posterUrlLandscape = result.backdrop_path

                itemContent.posterUrlPortrait = m.constants.imageUrl + posterUrlPortrait
                itemContent.posterUrlLandscape = m.constants.imageUrl + posterUrlLandscape
            end for
        end for
    end if

    return content
end function

