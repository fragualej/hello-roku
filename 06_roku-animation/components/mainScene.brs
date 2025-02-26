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
end sub

sub onSplashStateChanged()
    closeView()
    showHomeView()
end sub
