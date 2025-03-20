sub initViewStack()
    m.viewStack = []
end sub

sub navToView(config as object)
    view = config.view
    view.setFocus(true)

    if config.content <> invalid
        view.content = config.content
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