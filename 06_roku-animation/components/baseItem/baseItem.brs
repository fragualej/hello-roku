sub init()
    m.app = App()
    m.poster = m.top.findNode("poster")
    m.poster.update(m.app.itemFields.posterFields, true)
end sub

sub onContentChanged(event as object)
    content = event.getData()
    m.poster.uri = content.fhdPosterUrl
end sub

sub onFocusPercentChanged(event as object)
end sub
