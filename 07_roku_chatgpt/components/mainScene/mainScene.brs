sub init()
    print "DEBUG: mainScene - init()"
    m.top.repository = createObject("roSGNode", "repository")
    httpNode = createObject("roSGNode", "httpNode")
    httpNode.observeField("response", "onHttpResponse")
    request = {
        method: "GET",
        httpNode: httpNode
    }
    m.top.repository.callFunc("fetchChatGPT", request)
end sub

sub onHttpResponse(event as object)
    print "DEBUG: mainScene - onHttpResponse()", event.getData()
end sub