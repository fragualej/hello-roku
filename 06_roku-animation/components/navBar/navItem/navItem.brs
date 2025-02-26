sub init()
    navFields = app().navFields
    constants = constantsUtil_get()

    m.layoutGroup = m.top.findNode("layoutGroup")
    m.label = m.top.findNode("label")
    m.rectangle = m.top.findNode("rectangle")

    itemw = navFields.itemw
    itemh = navFields.itemh

    m.label.drawingStyles = constants.styles.multiStyles

    m.rectangle.width = itemw
    m.rectangle.height = itemh * 0.01

    m.layoutGroup.translation = [itemw * 0.5, 0]
    m.layoutGroup.itemSpacings = [itemh * 0.02]
end sub

sub onContentChanged(event as object)
    itemContent = event.getData()
    m.label.text = substitute("<h3>{0}</h3>", itemContent.genreName)
end sub

sub onFocusPercentChanged(event as object)
    focusPercent = event.getData()
    if focusPercent > 0.5
        m.label.text = substitute("<h2>{0}</h2>", m.top.itemContent.genreName)
        m.rectangle.visible = true
    else
        m.label.text = substitute("<h3>{0}</h3>", m.top.itemContent.genreName)
        m.rectangle.visible = false
    end if
end sub