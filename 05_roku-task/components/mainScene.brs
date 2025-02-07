sub init()
    print "MainScene - Init()"
    m.app = App()
    m.rowlist = m.top.findNode("rowlist")
    m.label = m.top.findNode("label")

    m.rowlist.update(m.app.gridFields)
    m.label.drawingStyles = {
        "h1": {
            "fontSize": 50
            "fontUri": "font:BoldSystemFontFile"
            "color": "#ffffff"
        }
        "h2": {
            "fontSize": 30
            "fontUri": "font:SystemFontFile"
            "color": "#ffffff"
        }
        "h3": {
            "fontSize": 24
            "fontUri": "font:SystemFontFile"
            "color": "#ffffff"
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

    m.label.text = Substitute("<h1>{0}</h1> {1} {1} <h2>{2}</h2>", itemContent.title, chr(10), itemContent.description)
end sub

sub onRowItemSelected(event as object)

end sub

