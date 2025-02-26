sub showHomeView()
    homeView = createObject("roSGNode", "homeView")
    homeView.observeField("itemSelected", "onGridItemSelected")
    navToView({ view: homeView })
end sub

sub OnGridItemSelected(event as object)
    itemSelected = event.getData()
    showDetailsView(itemSelected)
end sub