sub init()
    m.PI = mathUtils_PI()
    m.frameCount = 0
    m.freq = 0.25
    m.amp = 1

    m.label = m.top.findNode("label")
    m.label.drawingStyles = m.constants.styles.multiStyles

    setGrid()

    m.timer = m.top.findNode("timer")
    m.timer.ObserveField("fire", "onFire")
    m.timer.duration = 1 / 30
    m.timer.repeat = true
    m.timer.control = "start"
end sub

sub setGrid()
    rows = 7
    cols = 7
    grid = gridUtil_setGrid(rows, cols, true)

    gridw = grid.gridw
    gridh = grid.gridh
    cellw = grid.cellw
    cellh = grid.cellh
    itemw = grid.itemw

    ix = grid.ix
    iy = grid.iy

    m.label.setFields({
        width: gridw
        height: gridh * 0.1
        horizAlign: "center"
        translation: [ix, iy]
        text: "<h2>Loading...</h2>"
    })
    m.rectangle = m.top.findNode("rectangle")
    m.rectangle.width = gridw
    m.rectangle.height = gridh
    m.rectangle.translation = [ix, iy]

    for i = 0 to cols - 1
        col = i mod cols
        gapx = cellw * 0.25

        x = col * cellw + gapx
        y = (3 * cellh) + gapx

        rectangle = m.rectangle.createChild("rectangle")
        rectangle.color = "#eeeeee"
        rectangle.width = cellw * 0.5
        rectangle.height = cellw * 0.5
        rectangle.translation = [x, y]
        rectangle.scaleRotateCenter = [gapx, gapx]
        rectangle.rotation = m.PI * 0.25
    end for

end sub

sub onFire()
    m.frameCount++
    for i = 0 to m.rectangle.getChildCount() - 1
        child = m.rectangle.getChild(i)
        p = child.translation
        d = mathUtils_dist(p[0], p[1], 432, 432)

        angle = (m.frameCount + m.freq * d) * (m.PI / 180)
        n = m.amp * sin(angle)
        if n < 0 then n *= -1
        child.scale = [n, n]
    end for

    if angle > 2 * m.PI
        m.top.state = "finish"
    end if
end sub