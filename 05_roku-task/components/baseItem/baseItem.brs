sub init()
    m.app = App()
    m.poster = m.top.findNode("poster")
    m.poster.update(m.app.itemFields.posterFields, true)
end sub

sub onContentChange(event as object)
    content = event.getData()
    m.poster.uri = content.fhdPosterUrl
end sub

