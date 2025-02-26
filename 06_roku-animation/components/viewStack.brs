sub initViewStack()
    m.viewStack = []
end sub

sub initView()
    navToView({ view: "splashView" })
end sub

sub navToView(event as object)
    if type(event) = "roSGNodeEvent"
        data = event.getData()
    else
        data = event
    end if

    view = createObject("roSGNode", data.view)

    if data.content <> invalid
        view.content = data.content
    end if

    showView(view)
end sub

sub showView(node as object)
    m.views.appendChild(node)
    node.visible = true
    prev = m.viewStack.peek()
    if prev <> invalid
        prev.visible = false
    end if
    node.setFocus(true)
    m.viewStack.push(node)
end sub

sub closeView()
    last = m.viewStack.pop()
    m.views.removeChild(last)
    prev = m.viewStack.peek()
    if prev <> invalid
        prev.visible = true
        prev.setFocus(true)
    end if
end sub