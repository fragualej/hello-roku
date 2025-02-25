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
        translation: [grid.ix, grid.iy],
        itemSize: [grid.gridw, grid.cellh],
        rowItemSize: [grid.itemw, grid.itemh],
        rowItemSpacing: [grid.gapx, 0],
        itemSpacing: [0, grid.gapy]
    })
    m.top.observeField("content", "onContentChange")
end sub

sub onContentChange(event as object)
    content = event.getData()
    m.rowlist.content = content
    restartObservers()
end sub

sub restartObservers()
    m.rowlist.unobserveField("rowItemFocused")
    m.rowlist.unobserveField("rowItemSelected")
    m.rowlist.observeField("rowItemFocused", "onRowItemFocused")
    m.rowlist.observeField("rowItemFocused", "onRowItemSelected")
end sub