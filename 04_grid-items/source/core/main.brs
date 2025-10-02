sub main()
    screen = createObject("roSGScreen")
    port = createObject("roMessagePort")
    screen.setMessagePort(port)

    scene = screen.createScene("mainScene")
    screen.show()

    ' setTitleSession(scene)
    nodeUtil_createAbstractNode(scene, deviceUtil_getUIResolution(), "Session 04: [SceneGraph] - Grids")

    while(true)
        msg = wait(0, port)
        if type(msg) = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub
