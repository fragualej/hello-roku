sub init()
    print "MainScene - Init()"
    setVariables()
    setFields()
end sub

sub setVariables()
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.rectangle = m.top.findNode("rectangle")
end sub

sub setFields()
    b = getBoundingRect(m.layoutGroup)
    r = getResolution()

    x = (r.width  - b.width ) * 0.5 + m.rectangle.width * 0.5
    y = (r.height - b.height) * 0.5

    m.layoutGroup.translation = [x, y]
end sub

function getResolution() as object
    di = createObject("roDeviceInfo")
    return di.getUIResolution()
end function

function getBoundingRect(node as object) as object
    return node.boundingRect()
end function
