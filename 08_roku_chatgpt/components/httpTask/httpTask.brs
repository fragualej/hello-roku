sub init()
    m.port = createObject("roMessagePort")
    m.top.observeField("request", m.port)
    m.pendingXfers = {}
    m.top.functionName = "initHttpTask"
end sub

sub initHttpTask()
    while true
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
    newXfer = createObject("roUrlTransfer")
    newXfer.setCertificatesFile("common:/certs/ca-bundle.crt")
    newXfer.initClientCertificates()
    newXfer.setUrl(request.url)
    newXfer.setMessagePort(m.port)

    if request.method = "GET"
        newXfer.asyncGetToString()
    end if

    requestId = newXfer.getIdentity().toStr()
    m.pendingXfers[requestId] = { newXfer: newXfer, request: request }
end sub

sub handleResponse(event as object)
    code = event.getResponseCode()
    requestId = event.getSourceIdentity().toStr()
    request = m.pendingXfers[requestId].request

    body = event.getString()
    data = parseJson(body)
    model = getModelData(request.modelType, data)

    httpNode = request.httpNode
    httpNode.response = {data: model.data, code: code}
    
    m.pendingXfers[requestId] = invalid
end sub

function getModelData(modelType as string, data as object)
    model = createObject("roSGNode", modelType)
    model.callFunc("parseData", data)
    return model
end function
