sub init()
    m.repository = m.top.getScene().repository
    m.navBar = m.top.findNode("navBar")
    m.grid = m.top.findNode("grid")
    getGenres()
end sub

sub getGenres()
    httpNode = createObject("roSGNode", "httpNode")
    httpNode.observeField("response", "onHttpGenresResponse")

    m.repository.callFunc("getGenres", { httpNode: httpNode })
end sub

sub onHttpGenresResponse(event as object)
    response = event.getData()

    m.navBar.content = response.content
    m.navBar.setFocus(true)
    m.navBar.observeField("itemFocused", "onItemFocused")
end sub

sub onItemFocused(event as object)
    data = event.getData()
    httpNode = createObject("roSGNode", "httpNode")
    httpNode.observeField("response", "onHttpMoviesResponse")

    m.repository.callFunc("getMoviesByGenre", { httpNode: httpNode, genreId: data.genreId })
end sub

sub onHttpMoviesResponse(event as object)
    response = event.getData()
    m.grid.content = response.content
    m.grid.observeField("itemSelected", "onItemSelected")
end sub

sub onItemSelected(event as object)
    m.top.itemSelected = event.getData()
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "down"
            if m.navBar.isInFocusChain()
                m.grid.setFocus(true)
            end if
        else if key = "up"
            if m.grid.isInFocusChain()
                m.navBar.setFocus(true)
            end if
        end if
    end if
    return handled
end function