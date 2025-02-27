sub init()
    m.navBar = m.top.findNode("navBar")
    m.grid = m.top.findNode("grid")

    m.top.observeField("focusedChild", "onFocusChanged")

    m.grid.observeField("itemSelected", "onGridItemSelected")
    m.grid.observeField("rowFocusedIndex", "onGridRowFocused")

    m.navBar.observeField("itemFocused", "onItemFocused")

    m.pageIndexMax = 15
    m.pageIndex = 1
    m.currIndex = 0
    m.prevIndex = 0
    m.currGenreId = 0
    m.lastFocusedNode = m.navBar

    getGenres()
end sub

sub onFocusChanged()
    if m.top.hasFocus()
        m.lastFocusedNode.setFocus(true)
    end if
end sub

sub getGenres()
    httpNode = createObject("roSGNode", "httpNode")
    httpNode.observeField("response", "onHttpGenresResponse")

    m.repository.callFunc("getGenres", { httpNode: httpNode })
end sub

sub onHttpGenresResponse(event as object)
    response = event.getData()
    m.navBar.content = response.content
end sub

sub onItemFocused(event as object)
    data = event.getData()
    genreId = data.genreId
    if genreId <> m.currGenreId
        m.grid.content = invalid
        m.pageIndex = 1
        getMovies(genreId, m.pageIndex)
        m.currGenreId = genreId
    end if
end sub

sub getMovies(genreId, pageIndex)
    httpNode = createObject("roSGNode", "httpNode")
    httpNode.observeField("response", "onHttpMoviesResponse")

    m.repository.callFunc("getMoviesByGenre", { httpNode: httpNode, genreId: genreId, pageIndex: pageIndex })
end sub

sub onHttpMoviesResponse(event as object)
    response = event.getData()
    if m.pageIndex = 1
        m.grid.content = response.content
        m.pageIndex++
        getMovies(m.navBar.itemFocused.genreId, m.pageIndex)
    else if m.pageIndex = 2
        appendContent(response.content)
    else
        appendContent(response.content)
        m.grid.jumpToRowItem = [m.currIndex, 0]
    end if
end sub

sub appendContent(content)
    children = content.getChildren(-1, 0)
    if m.grid.content <> invalid
        m.grid.content.appendChildren(children)
    end if
end sub

sub onGridItemSelected(event as object)
    itemSelected = event.getData()
    genres = m.navBar.content.getChild(0).genres
    genresIds = itemSelected.genresIds

    text = ""
    for each genreId in genresIds
        for each genre in genres
            if genreId = genre.id
                text += " | " + genre.name
                exit for
            end if
        end for
    end for

    itemSelected.genresText = text
    m.top.itemSelected = itemSelected
    m.lastFocusedNode = m.grid
end sub

sub onGridRowFocused(event as object)
    m.prevIndex = m.currIndex
    m.currIndex = event.getData()
    if (m.currIndex - m.prevIndex > 0 and m.currIndex mod 2 = 1 and m.pageIndex <= m.pageIndexMax)
        m.pageIndex++
        genreId = m.navBar.itemFocused.genreId
        getMovies(genreId, m.pageIndex)
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "down"
            if m.navBar.isInFocusChain()
                m.grid.setFocus(true)
                handled = true
            end if
        else if key = "up"
            if m.grid.isInFocusChain()
                m.navBar.setFocus(true)
                handled = true
            end if
        else if key = "back"
            if m.grid.isInFocusChain()
                m.grid.jumpToRowItem = [0, 0]
                handled = true
            end if
        end if
    end if
    return handled
end function