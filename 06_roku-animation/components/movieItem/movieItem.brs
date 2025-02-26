sub init()
    constants = constantsUtil_get()

    m.poster = m.top.findNode("poster")
    m.rectangle = m.top.findNode("rectangle")
    m.label = m.top.findNode("label")
    m.group = m.top.findNode("group")

    m.label.drawingStyles = constants.styles.multiStyles

    itemw = app().gridFields.itemw
    itemh = app().gridFields.itemh

    labelFields = {
        width: itemw,
        height: itemh * 0.3,
        translation: [0, itemh * 0.7]
    }

    m.poster.update({
        width: itemw,
        height: itemh,
    }, true)

    m.rectangle.update(labelFields, true)
    m.label.update(labelFields, true)
end sub

sub onContentChanged(event as object)
    itemContent = event.getData()
    m.poster.uri = itemContent.posterUrlLandscape
    text = ""
    text += Substitute("<h3>{0}</h3>", itemContent.title)
    text += Substitute("<h4>{0}{1} | {2}</h4>", chr(10), itemContent.releaseDate, itemContent.voteAverage)
    m.label.text = text
end sub

sub onFocusPercentChanged(event as object)
    focusPercent = event.getData()
end sub
