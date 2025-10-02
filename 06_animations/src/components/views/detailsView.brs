sub init()
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.label = m.top.findNode("label")
    m.poster = m.top.findNode("poster")

    grid = gridUtil_setGrid(1, 2, false, 0.6)

    m.layoutGroup.setFields({
        translation: [grid.ix, grid.iy]
        itemSpacings: [grid.gapx]
    })
    m.label.setFields({
        drawingStyles: m.constants.styles.multiStyles,
        width: grid.itemw
    })
    m.poster.setFields({
        width: grid.itemw
    })

    m.top.observeField("content", "onContentChanged")
end sub

sub onContentChanged(event as object)
    content = event.getData()
    m.poster.uri = content.posterUrlPortrait
    text = ""
    text += substitute("<h2>{0}{1}</h2>", content.title, chr(10))
    text += substitute("<h4>{0} {1}{2}{2}</h4>", content.releaseDate, content.genresText, chr(10))
    text += substitute("<h3>{0}</h3>", content.description)
    m.label.text = text
end sub