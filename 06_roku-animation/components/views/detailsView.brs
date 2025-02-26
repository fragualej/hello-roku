sub init()
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.label = m.top.findNode("label")
    m.poster = m.top.findNode("poster")

    constants = constantsUtil_get()
    m.label.drawingStyles = constants.styles.multiStyles
    m.top.observeField("content", "onContentChanged")
end sub

sub onContentChanged(event as object)
    content = event.getData()
    print "[DEBUG] onContentChanged: ", content
    m.poster.uri = content.posterUrlPortrait
    text = ""
    text += substitute("<h2>{0}{1}</h2>", content.title, chr(10))
    text += substitute("<h3>{0}{1}</h3>", content.releaseDate, chr(10))
    text += substitute("<h3>{0}</h3>", content.description)
    m.label.text = text
end sub