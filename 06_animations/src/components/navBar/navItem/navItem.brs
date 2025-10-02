sub init()
    navFields = m.app.navFields

    m.label = m.top.findNode("label")
    m.rectangle = m.top.findNode("rectangle")

    itemw = navFields.itemw
    itemh = navFields.itemh

    m.label.setFields({
        drawingStyles: m.constants.styles.multiStyles,
        width: itemw,
        height: itemh,
        horizAlign: "center",
        vertAlign: "center",
    })

    m.rectangle.setFields({
        width: itemw,
        height: itemh,
        color: "#3355ff",
    })
end sub

sub onContentChanged(event as object)
    itemContent = event.getData()
    m.label.text = substitute("<h3>{0}</h3>", itemContent.genreName)
end sub

sub onFocusPercentChanged(event as object)
    focusPercent = m.top.focusPercent
    if m.top.rowHasFocus
        if focusPercent > 0.5
            focusedState()
        else
            unFocusedState()
        end if
    else
        if focusPercent > 0.5
            selectedState()
        end if
    end if
end sub

sub focusedState()
    m.rectangle.color = "#3355ff"
end sub

sub unFocusedState()
    m.rectangle.color = "#9398b5"
end sub

sub selectedState()
    m.rectangle.color = "#3355ff"
end sub