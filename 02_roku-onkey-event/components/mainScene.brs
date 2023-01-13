sub init()
    print "MainScene - Init()"
    setVariables()    
    setConfig()
    setObservers()

    m.fishItem.setFocus(true)
end sub

sub setVariables()
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.fishItem = m.top.findNode("fishItem")
    m.birdItem = m.top.findNode("birdItem")
end sub

sub setConfig()
    r = getResolution()
    b = m.layoutGroup.boundingRect()
    x = (r.width  - b.width ) * 0.5
    y = (r.height - b.height) * 0.5

    m.layoutGroup.translation = [x, y]
end sub

sub setObservers()
    m.fishItem.observeField("focusedChild", "onFocusedChild")
    m.birdItem.observeField("focusedChild", "onFocusedChild")
end sub

sub onFocusedChild(event as object)
    node =  event.getNode()
    print "onFocusedChild", node, m.fishItem.hasFocus(), m.birdItem.hasFocus()
    if m.fishItem.hasFocus()
        m.fishItem.findNode("fishRect").color = "#FF00FF"
        m.fishItem.opacity = 1.0
    else
        m.fishItem.findNode("fishRect").color = "#FFFFFF"
        m.fishItem.opacity = 0.25
    end if

    if m.birdItem.hasFocus()
        m.birdItem.findNode("birdRect").color = "#FF00FF"
        m.birdItem.opacity = 1.0
    else
        m.birdItem.findNode("birdRect").color = "#FFFFFF"
        m.birdItem.opacity = 0.25
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handle = false
    if press
        if key = "right"
            if m.fishItem.hasFocus() then m.birdItem.setFocus(true)
        else key = "left"
            if m.birdItem.hasFocus() then m.fishItem.setFocus(true)
        end if
    end if
    return handle
end function

function getResolution() as object
    di = createObject("roDeviceInfo")
    return di.getUIResolution()
end function
