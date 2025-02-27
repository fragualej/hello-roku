sub init()
    m.pageIndex = 1
    m.navBar = m.top.findNode("navBar")
    m.grid = m.top.findNode("grid")

    m.grid.observeField("itemSelected", "onGridItemSelected")
    m.grid.observeField("rowFocusedIndex", "onGridRowFocused")

    m.navBar.observeField("itemFocused", "onItemFocused")

    m.top.observeField("focusedChild", "onFocusChanged")

    getGenres()
end sub

sub getGenres()
    httpNode = createObject("roSGNode", "httpNode")
    httpNode.observeField("response", "onHttpGenresResponse")

    m.repository.callFunc("getGenres", { httpNode: httpNode })
end sub

sub onFocusChanged()
    if m.top.hasFocus()
        m.navBar.setFocus(true)
    end if
end sub

sub onHttpGenresResponse(event as object)
    response = event.getData()
    m.navBar.content = response.content
end sub

sub onItemFocused(event as object)
    data = event.getData()
    m.grid.content = invalid
    m.pageIndex = 1
    getMovies(data.genreId, m.pageIndex)
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
        content = response.content
        children = content.getChildren(-1, 0)
        if m.grid.content <> invalid
            m.grid.content.appendChildren(children)
        end if
    else
        content = response.content
        children = content.getChildren(-1, 0)
        if m.grid.content <> invalid
            m.grid.content.appendChildren(children)
            rowIndex = m.grid.content.getChildCount()
            m.grid.jumpToRowItem = [rowIndex - 2, 0]
        end if
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
end sub

sub onGridRowFocused(event as object)
    rowFocusedIndex = event.getData()
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "down"
            if m.navBar.isInFocusChain()
                m.grid.setFocus(true)
                handled = true
            else
                if m.pageIndex <= 15
                    m.pageIndex++
                    genreId = m.navBar.itemFocused.genreId
                    getMovies(genreId, m.pageIndex)
                end if
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