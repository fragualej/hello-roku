sub init()
    m.appColors = getAppColors()

    m.KidsCustomKeyboard = m.top.findNode("KidsCustomKeyboard")
    m.KidsCustomKeyboard.translation = [200, 550]

    m.RectangleKids1 = m.top.findNode("RectangleKids1")
    m.RectangleKids1.color = m.appColors.BACKGROUND_COLOR
    m.RectangleKids1.width = 1920
    m.RectangleKids1.height = 1080
    m.RectangleKids1.translation = [0, 0]

    m.RectangleKids2 = m.top.findNode("RectangleKids2")
    m.RectangleKids2.color = m.appColors.YELLOW
    m.RectangleKids2.width = 1200
    m.RectangleKids2.height = 980
    m.RectangleKids2.translation = [360, 50]

    m.RectangleKids3 = m.top.findNode("RectangleKids3")
    m.RectangleKids3.color = m.appColors.PINK
    m.RectangleKids3.width = 400
    m.RectangleKids3.height = 100
    m.RectangleKids3.translation = [200, -40]

    m.RectangleKids4 = m.top.findNode("RectangleKids4")
    m.RectangleKids4.color = m.appColors.WHITE
    m.RectangleKids4.width = 800
    m.RectangleKids4.height = 400
    m.RectangleKids4.translation = [200, 100]

    m.SimpleLabelKids = m.top.findNode("SimpleLabelKids")
    m.SimpleLabelKids.color = m.appColors.WHITE
    m.SimpleLabelKids.translation = [90, 30]
    m.SimpleLabelKids.fontUri = "font:MediumBoldSystemFont"
    m.SimpleLabelKids.text = "ASK PBS KIDS"
end sub