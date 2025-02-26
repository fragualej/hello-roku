sub init()
    m.constants = constantsUtil_get()
    m.rowlist = m.top.findNode("rowlist")
    rows = 3
    cols = 3
    grid = gridUtil_getGridValues(rows, cols, deviceUtil_getUIResolution())
    m.rowlist.update({
        itemComponentName: "movieItem",
        rowFocusAnimationStyle: "fixedFocus",
        drawFocusFeedback: true,
        numRows: rows,
        translation: [grid.ix, grid.iy * 2.25],
        itemSize: [grid.gridw, grid.cellh],
        rowItemSize: [grid.itemw, grid.itemh],
        rowItemSpacing: [grid.gapx, 0],
        itemSpacing: [0, grid.gapy]
    })

    m.top.observeField("focusedChild", "onFocusChanged")
    m.top.observeField("content", "onContentChanged")
    m.rowlist.observeField("rowItemSelected", "onRowItemSelected")
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