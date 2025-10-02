sub init()
    m.views = m.top.findNode("views")
    m.top.repository = createObject("roSGNode", "repository")

    initViewStack()
    initView()
end sub

sub initView()
    splashView = createObject("roSGNode", "splashView")
    splashView.observeField("state", "onSplashStateChanged")
    navToView({ view: splashView })
    print "[DEBUG]"
end sub

sub onSplashStateChanged()
    closeView()
    showHomeView()
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "back"
            closeView()
            handled = true
        end if
    end if
    return handled
end function
