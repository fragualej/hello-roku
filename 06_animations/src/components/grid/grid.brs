sub init()
    setRowListConfig()
    setObservers()
end sub

sub setRowListConfig()
    grid = m.app.gridFields
    ix = grid.ix
    iy = grid.iy
    rows = grid.rows
    gridw = grid.gridw
    gridh = grid.gridh
    cellw = grid.cellw
    cellh = grid.cellh
    itemw = grid.itemw
    itemh = grid.itemh
    gapx = grid.gapx
    gapy = grid.gapy

    m.rowlist = m.top.findNode("rowlist")
    m.rowlist.update({
        itemComponentName: "movieItem",
        vertFocusAnimationStyle: "fixedFocus",
        rowFocusAnimationStyle: "fixedFocusWrap",
        drawFocusFeedback: true,
        numRows: rows - 1,
        translation: [ix, iy + (cellh + gapy) * 0.75],
        itemSize: [gridw, cellh],
        itemClippingRect: [0, 0, gridw, cellh * 2],
        rowItemSize: [itemw, itemh],
        rowItemSpacing: [gapx, 0],
        itemSpacing: [0, gapy],
    })
end sub

sub setObservers()
    m.top.observeField("focusedChild", "onFocusChanged")
    m.top.observeField("content", "onContentChanged")
    m.top.observeField("jumpToRowItem", "onJumpToItem")

    m.rowlist.observeField("rowItemSelected", "onRowItemSelected")
    m.rowlist.observeField("rowItemFocused", "onRowItemFocused")
    m.rowlist.observeField("itemFocused", "onRowFocused")
end sub

sub onFocusChanged()
    if m.top.hasFocus()
        m.rowlist.setFocus(true)
    end if
end sub

sub onContentChanged(event as object)
    content = event.getData()
    m.rowlist.content = content
end sub

sub onRowItemSelected(event as object)
    rowItemIndex = event.getData()
    rowContent = m.rowlist.content.getChild(rowItemIndex[0])
    itemContent = rowContent.getChild(rowItemIndex[1])

    m.top.itemSelected = itemContent
end sub

sub onRowItemFocused(event as object)
    rowItemIndex = event.getData()
    rowContent = m.rowlist.content.getChild(rowItemIndex[0])
    itemContent = rowContent.getChild(rowItemIndex[1])

    m.top.itemFocused = itemContent
end sub

sub onRowFocused(event as object)
    rowFocusedIndex = event.getData()
    m.top.rowFocusedIndex = event.getData()
end sub

sub onJumpToItem(event as object)
    rowItemIndex = event.getData()
    m.rowlist.jumpToRowItem = rowItemIndex
end sub