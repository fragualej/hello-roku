sub init()
    m.rowlist = m.top.findNode("rowlist")

    m.top.observeField("content", "onContentChanged")
    m.top.observeField("focusedChild", "onFocusChanged")
end sub

sub onFocusChanged()
    if m.top.hasFocus()
        m.rowlist.setFocus(true)
    end if
end sub

sub onContentChanged(event as object)
    content = event.getData()
    grid = m.app.navFields

    ix = grid.ix
    iy = grid.iy
    gridw = grid.gridw
    gridh = grid.gridh
    cellw = grid.cellw
    cellh = grid.cellh
    itemw = grid.itemw
    itemh = grid.itemh
    gapx = grid.gapx
    gapy = grid.gapy

    m.rowlist.setFields({
        itemComponentName: "navItem",
        drawFocusFeedback: false,
        translation: [grid.ix, grid.iy * 3],
        itemSize: [grid.gridw, grid.gridh],
        rowItemSize: [grid.itemw, grid.itemh],
        rowItemSpacing: [grid.gapx, 0]
    })
    m.rowlist.content = content
    m.rowlist.observeField("rowItemFocused", "onItemFocused")
end sub

sub onItemFocused(event as object)
    rowItemIndex = event.getData()
    itemContent = m.rowlist.content.getChild(rowItemIndex[0]).getChild(rowItemIndex[1])
    m.top.itemFocused = { genreId: itemContent.genreId, genreName: itemContent.genreName }
end sub