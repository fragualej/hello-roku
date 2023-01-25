sub init()
    m.player = m.top.findNode("player")
    m.playerBar = m.top.findNode("playerBar")
    
    'set focus
    m.top.setFocus(true)

    'set observers
    m.top.observeField("focusedChild", "onFocusChanged")
    m.player.observeField("state", "playerStateChanged")
    m.player.observeField("position", "playerPositionChanged")
    m.playerBar.observeField("hideMe", "hidePlayerBar")
    m.playerBar.observeField("control", "playerBarControlChanged")
    setPlayer()
end sub

sub setPlayer()
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"
    videoContent.title = "HLS Video"
    videoContent.streamformat = "hls"

    m.player.content = videoContent
    m.player.control = "play"
end sub

sub hidePlayerBar()
    m.playerBar.isVisible = false
    m.player.setFocus(true)
end sub

sub onFocusChanged()
    if m.top.hasFocus() then
        m.top.findNode("player").setFocus(true)
    end if
end sub

sub playerStateChanged()
    m.playerBar.status = m.player.state
end sub

sub playerPositionChanged()
    m.playerBar.duration = m.player.duration
    m.playerBar.position = m.player.position
end sub

sub playerBarControlChanged()
    m.player.control = m.playerBar.control
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press then
        if key = "up" and m.playerBar.visible = false then
            handled = true
            m.playerBar.isVisible = true
        end if
    end if
    return handled
end function
