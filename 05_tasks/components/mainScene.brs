sub init()
    print "MainScene - Init()"
    m.app = app()
    m.constants = constantsUtil_get()
    print "constants", m.constants

    m.rowlist = m.top.findNode("rowlist")
    m.label = m.top.findNode("label")

    m.rowlist.update(m.app.gridFields)
    m.label.drawingStyles = {
        "h1": {
            "fontSize": 55
            "fontUri": "font:BoldSystemFontFile"
            "color": "#00000"
        }
        "h2": {
            "fontSize": 30
            "fontUri": "font:SystemFontFile"
            "color": "#00000"
        }
        "h3": {
            "fontSize": 24
            "fontUri": "font:SystemFontFile"
            "color": "#00000"
        }
    }
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

    text = ""
    text += Substitute("<h1>{0}</h1>", itemContent.title)
    text += chr(10)
    text += Substitute("<h2> {0} | {1}</h2>", itemContent.releaseDate, itemContent.voteAverage)
    text += chr(10)
    text += Substitute("<h3>{0}</h3>", itemContent.description)
    m.label.text = text
end sub

sub onRowItemSelected(event as object)

end sub

