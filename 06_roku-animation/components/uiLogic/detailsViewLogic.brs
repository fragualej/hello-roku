sub showDetailsView(content as object)
    detailsView = createObject("roSGNode", "detailsView")
    detailsView.observeField("itemSelected", "onDetailsItemSelected")
    navToView({
        view: detailsView
        content: content
    })
end sub

sub onDetailsItemSelected(event as object)
    itemSelected = event.getData()
end sub