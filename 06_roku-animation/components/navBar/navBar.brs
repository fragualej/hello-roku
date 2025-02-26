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
    navFields = app().navFields

    m.rowlist.setFields({
        itemComponentName: "navItem"
        drawFocusFeedback: false
        translation: [navFields.ix, navFields.iy]
        itemSize: [navFields.gridw, navFields.gridh]
        rowItemSize: [navFields.itemw, navFields.itemh]
        rowItemSpacing: [navFields.gapx, 0]
    })
    m.rowlist.content = content
    m.rowlist.observeField("rowItemFocused", "onItemFocused")
end sub

sub onItemFocused(event as object)
    rowItemIndex = event.getData()
    itemContent = m.rowlist.content.getChild(rowItemIndex[0]).getChild(rowItemIndex[1])
    m.top.itemFocused = { genreId: itemContent.genreId, genreName: itemContent.genreName }
end sub