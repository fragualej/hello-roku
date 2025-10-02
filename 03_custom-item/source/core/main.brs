sub main()
    screen = createObject("roSGScreen")
    port = createObject("roMessagePort")
    screen.setMessagePort(port)

    scene = screen.createScene("mainScene")
    screen.show()

    setTitleSession(scene)

    while(true)
        msg = wait(0, port)
        if type(msg) = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub

sub setTitleSession(scene)
    text = "Session 03: [SceneGraph] Custom Item"

    r = getUIResolution()
    x = r.width * 0.05
    y = r.width * 0.05

    abstractNode = createObject("roSGNode", "abstractNode")
    abstractNode.content = {text: text, fontSize: r.height * 0.025}
    abstractNode.translation = [x, y]

    scene.appendChild(abstractNode)
end sub

function getUIResolution() as object
    di = createObject("roDeviceInfo")
    return di.getUIResolution()
end function