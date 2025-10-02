sub init()
    m.poster = m.top.findNode("poster")
    m.poster.update({
        width: m.app.gridFields.itemw,
        height: m.app.gridFields.itemh
    }, true)
end sub

sub onContentChanged(event as object)
    itemContent = event.getData()
    m.poster.uri = itemContent.posterUrlPortrait
end sub

sub onFocusPercentChanged(event as object)
end sub
