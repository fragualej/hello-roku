sub init()
    m.rectangle = m.top.findNode("rectangle")
    m.label = m.top.findNode("label")
    m.top.observeField("focusedChild","onFocusChange")
end sub

sub onFocusChange(event as object)
    if m.top.hasFocus()
        m.rectangle.color = "#57B8B0"
    else
        m.rectangle.color = "#FFFFFF"
    end if
end sub

sub onContentChange(event as object)
    content = event.getData()
    ' rectangle fields
    m.rectangle.width  = content.width
    m.rectangle.height = content.height
    m.rectangle.color = content.rectColor
    ' label fields
    m.label.width = content.width
    m.label.height = content.height
    m.label.color = content.textColor
    m.label.font.size = content.fontSize

    m.top.text = content.text
end sub