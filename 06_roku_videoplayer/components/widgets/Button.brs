sub init()
    m.border = m.top.findNode("border")
    m.background = m.top.findNode("background")
    m.label = m.top.findNode("label")
    m.top.observeField("focusedChild", "onFocusChanged")
end sub

sub onFocusChanged()
    m.border.visible = m.top.isInFocusChain()
end sub

sub textChanged()
    m.label.text = m.top.text
end sub

sub widthChanged()
    m.border.width = m.top.width + 10
    m.background.width = m.top.width
    m.label.width = m.top.width
end sub

sub heightChanged()
    m.border.height = m.top.height + 10
    m.background.height = m.top.height
    m.label.height = m.top.height
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press = true then
        if key = "OK" then
            handled = true
            m.top.pressed = true
        end if
    end if
    return handled
end function