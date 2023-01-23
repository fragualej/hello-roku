sub init()
    m.constants = {
        baseUrl: "https://api.themoviedb.org/3/trending/movie/week?api_key="
        imageUrl: "https://image.tmdb.org/t/p/w500"
        apiKey: "558e2410c2be44f6e971c2b2c8cf64d0"

    }
    m.top.functionName = "initHttpTask"
end sub

sub initHttpTask()
    url = m.constants.baseUrl + m.constants.apiKey

    'handle request
    urlTransfer = createObject("roUrlTransfer")
    urlTransfer.setCertificatesFile("common:/certs/ca-bundle.crt")
    urlTransfer.initClientCertificates()
    urlTransfer.setUrl(url)
    urlTransfer.setMessagePort(m.port)
    
    handleResponse(urlTransfer.getToString())
end sub

sub handleResponse(body)
    data = parseJson(body)
    results = data.results
    
    rows = 4
    cols = 5

    content = createObject("roSGNode", "ContentNode")
    for j = 0 to rows - 1
        rowContent = content.createChild("ContentNode")
        for i = 0 to cols - 1
            idx = j * cols + i
            result = results[idx]
            itemContent = rowContent.createChild("ContentNode")
            itemContent.id = result.id
            itemContent.title = result.title
            itemContent.description = result.overview
            itemContent.fhdPosterUrl = m.constants.imageUrl + result.backdrop_path
        end for
    end for

    rowChildren = content.getChildren(-1, 0)
    itemChildren = rowChildren[0].getChildren(-1, 0)
    print rowChildren, itemChildren
    
    response = {}
    response.content = content
    m.top.response = response
end sub

