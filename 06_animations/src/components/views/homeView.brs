sub init()
    setComponents()
    setObservers()
    setLocalVariables()
    getGenres()
end sub

sub setComponents()
    m.label = m.top.findNode("label")
    m.label.setFields({
        drawingStyles: m.constants.styles.multiStyles,
        translation: [m.app.gridFields.ix, m.app.gridFields.iy * 1.5],
        width: m.app.gridFields.gridw
    })
    m.navBar = m.top.findNode("navBar")
    m.grid = m.top.findNode("grid")
end sub

sub setObservers()
    m.top.observeField("focusedChild", "onFocusChanged")

    m.grid.observeField("itemSelected", "onGridItemSelected")
    m.grid.observeField("itemFocused", "onGridItemFocused")
    m.grid.observeField("rowFocusedIndex", "onGridRowFocused")

    m.navBar.observeField("itemFocused", "onItemFocused")
end sub

sub setLocalVariables()
    m.pageIndexMax = 10
    m.pageIndex = 1
    m.currIndex = 0
    m.prevIndex = 0
    m.currGenreId = 0
    m.gridChildren = createObject("roSGNode", "contentNode")
    m.gridContent = createObject("roSGNode", "contentNode")
    m.lastFocusedNode = m.navBar
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
        m.label.text = ""
        m.grid.content = invalid
        m.gridContent = invalid
        m.gridContent = createObject("roSGNode", "contentNode")
        m.pageIndex = 1
        getMovies(genreId, m.pageIndex)
        m.currGenreId = genreId
    end if
end sub

sub getMovies(genreId, pageIndex)
    httpNode = createObject("roSGNode", "httpNode")
    httpNode.observeField("response", "onHttpMoviesResponse")

    for i = 0 to 2
        m.repository.callFunc("getMoviesByGenre", { httpNode: httpNode, genreId: genreId, pageIndex: pageIndex + i })
    end for
end sub

sub onHttpMoviesResponse(event as object)
    response = event.getData()
    content = response.content
    children = content.getChildren(-1, 0)
    m.gridChildren.appendChildren(children)

    if m.gridChildren.getChildCount() = 60
        rows = 2
        cols = 30
        for j = 0 to rows - 1
            rowContent = m.gridContent.createChild("contentNode")
            for i = 0 to cols - 1
                idx = j * cols + i
                child = m.gridChildren.getChild(idx).clone(true)
                rowContent.appendChild(child)
            end for
        end for
        m.grid.content = m.gridContent
        m.grid.jumpToRowItem = [m.currIndex, 0]
        m.gridChildren = invalid
        m.gridChildren = createObject("roSGNode", "contentNode")
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

sub onGridItemFocused(event as object)
    itemFocused = event.getData()
    setLabelText(itemFocused)
end sub

sub onGridRowFocused(event as object)
    m.prevIndex = m.currIndex
    m.currIndex = event.getData()
    if m.currIndex - m.prevIndex > 0 and m.currIndex mod 2 = 1 and m.pageIndex <= m.pageIndexMax
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

sub setLabelText(itemContent as object)
    text = ""
    text += substitute("<h1>{0}</h1>", itemContent.title)
    text += substitute("<h3>{0}{1} | {2}</h3>", chr(10), itemContent.releaseDate, itemContent.voteAverage)
    m.label.text = text
end sub