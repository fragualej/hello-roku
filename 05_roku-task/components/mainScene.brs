sub init()
    print "MainScene - Init()"
    m.app = App()
    m.rowlist = m.top.findNode("rowlist")
    m.label = m.top.findNode("label")

    m.rowlist.update(m.app.gridFields)
    m.label.update(m.app.labelFields)

    m.rowlist.observeField("rowItemFocused", "onRowItemFocused")
    m.rowlist.observeField("rowItemFocused", "onRowItemSelected")

    m.httpTask = createObject("roSGNode", "httpTask")
    m.httpTask.observeField("response", "onHttpResponse")
    m.httpTask.control = "run"
end sub

sub onHttpResponse(event as object)
    response = event.getData()

    m.rowlist.content = response.content
    m.rowlist.setFocus(true)
end sub

sub onRowItemFocused(event as object)
    rowItemIndex = event.getData()
    
    content = m.rowlist.content
    rowContent = content.getChild(rowItemIndex[0])
    itemContent = rowContent.getChild(rowItemIndex[1])

    m.label.text = itemContent.title
end sub

sub onRowItemSelected(event as object)

end sub

