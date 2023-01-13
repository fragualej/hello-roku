sub init()
    print "MainScene - Init()"
    setVariables()
    setConfig()
end sub

sub setVariables()
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.top.index = 0
    m.top.maxIndex = m.layoutGroup.getChildCount() - 1
end sub

sub setConfig()
    r = getResolution()
    b = m.layoutGroup.boundingRect()
    x = (r.width  - b.width ) * 0.5
    y = (r.height - b.height) * 0.5

    m.layoutGroup.translation = [x, y]
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handle = false
    if press
        if key = "right"
            if m.top.index < m.top.maxIndex
                m.top.index++
                print "index++ ", m.top.index 
            end if
        else key = "left"
            if m.top.index > 0 
                m.top.index--
                print "index-- ", m.top.index
            end if
        end if
    end if
    return handle
end function

sub onIndexChange(event as object)
    index = event.getData()
    m.layoutGroup.getChild(index).setFocus(true)
end sub

function getResolution() as object
    di = createObject("roDeviceInfo")
    return di.getUIResolution()
end function
