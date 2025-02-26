sub init()
    m.views = m.top.findNode("views")
    m.timer = m.top.findNode("timer")
    m.top.repository = createObject("roSGNode", "repository")
    initViewStack()
    initView()

    m.timer.ObserveField("fire", "onFire")
    m.timer.control = "start"
    ' getGenres()
end sub

sub onFire()
    closeView()
    navToView({ view: "homeView" })
end sub

' sub getGenres()
'     httpNode = createObject("roSGNode", "httpNode")
'     httpNode.observeField("response", "onHttpGenresResponse")

'     m.top.repository.callFunc("getGenres", { httpNode: httpNode })
' end sub

' sub onHttpGenresResponse(event as object)
'     response = event.getData()

'     m.navBar = m.top.findNode("navBar")
'     m.navBar.content = response.content
'     m.navBar.setFocus(true)
'     m.navBar.observeField("itemFocused", "onItemFocused")
' end sub

' sub onItemFocused(event as object)
'     data = event.getData()
'     httpNode = createObject("roSGNode", "httpNode")
'     httpNode.observeField("response", "onHttpMoviesResponse")

'     m.top.repository.callFunc("getMoviesByGenre", { httpNode: httpNode, genreId: data.genreId })
' end sub

' sub onHttpMoviesResponse(event as object)
'     response = event.getData()

'     m.homeView = m.top.findNode("homeView")
'     m.homeView.content = response.content
' end sub
