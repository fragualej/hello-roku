sub init()
    m.label = m.top.findNode("label")
    m.rectangle = m.top.findNode("rectangle")
    m.constants = constantsUtil_get()
    m.label.drawingStyles = m.constants.styles.multiStyles
end sub

sub onContentChanged(event as object)
    itemContent = event.getData()
    m.label.text = substitute("<h1>{0}</h1>", itemContent.title)
end sub

sub onFocusPercentChanged(event as object)
end sub