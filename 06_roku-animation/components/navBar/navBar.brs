sub init()
    m.rowlist = m.top.findNode("rowlist")

    items = ["Action", "Adventure", "Animation", "Comedy", "Horror"]
    content = createObject("roSGNode", "contentNode")
    rowContent = content.createChild("contentNode")

    for each item in items
        itemContent = rowContent.createChild("contentNode")
        itemContent.title = item
    end for

    res = deviceUtil_getUIResolution()
    width = res.width
    height = res.height

    navw = width * 0.8
    navh = width * 0.1

    itemw = (navw / 5) * 0.9
    itemh = navh * 0.9

    ix = (width - navw) * 0.5
    iy = (height - navh) * 0.1

    gapx = itemw * 0.1

    m.rowlist.setFields({
        itemComponentName: "navItem"
        drawFocusFeedback: true
        translation: [ix, iy]
        itemSize: [navw, navh]
        rowItemSize: [itemw, itemh]
        rowItemSpacing: [gapx, 0]
        content: content
    })

    print "[DEBUG] navBar:", content
end sub