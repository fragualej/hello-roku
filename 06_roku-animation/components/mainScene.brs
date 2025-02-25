sub init()
    m.app = app()
    m.constants = constantsUtil_get()
    m.rowlist = m.top.findNode("rowlist")
    m.label = m.top.findNode("label")
    m.homeView = m.top.findNode("homeView")

    m.rowlist.update(m.app.gridFields)
    m.label.update(m.app.labelFields)
    m.label.drawingStyles = m.constants.styles.multiStyles

    m.rowlist.observeField("rowItemFocused", "onRowItemFocused")
    m.rowlist.observeField("rowItemFocused", "onRowItemSelected")

    m.httpTask = createObject("roSGNode", "httpTask")
    m.httpTask.control = "run"
    m.httpTask.observeField("response", "onHttpResponse")
    m.httpTask.request = {}
end sub

sub onHttpResponse(event as object)
    response = event.getData()
    m.homeView.content = response.content
end sub

sub onRowItemFocused(event as object)
    rowItemIndex = event.getData()

    content = m.rowlist.content
    rowContent = content.getChild(rowItemIndex[0])
    itemContent = rowContent.getChild(rowItemIndex[1])

    text = ""
    text += Substitute("<h2>{0}</h2>", itemContent.title)
    text += chr(10)
    text += Substitute("<h2> {0} | {1}</h2>", itemContent.releaseDate, itemContent.voteAverage)
    text += chr(10)
    text += Substitute("<h3>{0}</h3>", itemContent.description)
    m.label.text = text
end sub

sub onRowItemSelected(event as object)

end sub

