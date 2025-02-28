sub init()
    setRowListConfig()
    setObservers()
end sub

sub setRowListConfig()
    grid = m.app.gridFields

    m.rowlist = m.top.findNode("rowlist")
    m.rowlist.update({
        itemComponentName: "movieItem",
        vertFocusAnimationStyle: "floatingFocus",
        rowFocusAnimationStyle: "fixedFocusWrap"
        drawFocusFeedback: true,
        numRows: grid.rows - 1,
        translation: [grid.ix, grid.iy * 2.25],
        itemSize: [grid.gridw + grid.cellw * 2, grid.cellh],
        itemClippingRect: [0, 0, grid.gridw + grid.cellw * 2, grid.cellh * 2]
        rowItemSize: [grid.itemw, grid.itemh],
        rowItemSpacing: [grid.gapx, 0],
        itemSpacing: [0, grid.gapy],
    })
end sub

sub setObservers()
    m.top.observeField("focusedChild", "onFocusChanged")
    m.top.observeField("content", "onContentChanged")
    m.top.observeField("jumpToRowItem", "onJumpToItem")

    m.rowlist.observeField("rowItemSelected", "onRowItemSelected")
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

sub onRowFocused(event as object)
    rowFocusedIndex = event.getData()
    m.top.rowFocusedIndex = event.getData()
end sub

sub onJumpToItem(event as object)
    rowItemIndex = event.getData()
    m.rowlist.jumpToRowItem = rowItemIndex
end sub