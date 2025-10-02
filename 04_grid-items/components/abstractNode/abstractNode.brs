sub init()
    m.label = m.top.findNode("label")
    m.rectangle = m.top.findNode("rectangle")
    m.dateTimeLabel = m.top.findNode("dateTimeLabel")
end sub

sub onContentChange(event as object)
    content = event.getData()
    title = content.title
    fontSize = content.fontSize

    m.label.update(content, true)

    boundingRect = m.label.boundingRect()

    m.rectangle.width  = boundingRect.width  
    m.rectangle.height = boundingRect.height * 0.2

    m.dateTimeLabel.fontSize = content.fontSize
    m.dateTimeLabel.text = getDateTime()
end sub

function getDateTime()
    dt = createObject("roDateTime")
    return dt.AsDateString("short-month-no-weekday")
end function