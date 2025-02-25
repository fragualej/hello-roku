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
            handleRequest()
        else if type(msg) = "roUrlEvent"
            handleResponse(msg)
        end if
    end while
end sub

sub handleRequest(event = {} as object)
    url = m.constants.baseUrl + m.constants.apiKey
    job = createObject("roUrlTransfer")
    job.setUrl(url)
    job.setCertificatesFile("common:/certs/ca-bundle.crt")
    job.initClientCertificates()
    job.setMessagePort(m.port)
    job.asyncGetToString()
    requestId = job.getIdentity().toStr()
    m.jobs[requestId] = job
end sub

sub handleResponse(event as object)
    requestId = event.getSourceIdentity().toStr()
    job = m.jobs[requestId]

    if job <> invalid
        code = event.getResponseCode()
        if code <= 200 and code < 300
            print code, requestId
            body = event.getString()
            data = parseJson(body)
            m.top.response = buildResponse(data)
        end if
    end if
end sub

function buildResponse(data as object)
    results = data.results
    rows = 4
    cols = 5

    content = createObject("roSGNode", "contentNode")
    for j = 0 to rows - 1
        rowContent = content.createChild("contentNode")
        for i = 0 to cols - 1
            idx = j * cols + i
            result = results[idx]
            itemContent = rowContent.createChild("movieCardNode")
            itemContent.id = result.id
            itemContent.title = result.title
            itemContent.description = result.overview
            itemContent.popularity = result.popularity.toStr()
            itemContent.releaseDate = result.release_date
            itemContent.voteAverage = result.vote_average
            itemContent.originalLanguage = result.original_language
            itemContent.fhdPosterUrl = m.constants.imageUrl + result.backdrop_path
        end for
    end for

    response = {}
    response.content = content
    return response
end function

