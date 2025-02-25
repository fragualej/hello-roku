function app()
    m.app = m.global.app

    if m.app = invalid
        m.app = {}

        r = deviceUtil_getUIResolution()
        width = r.width
        height = r.height

        rows = 3
        cols = 3

        gridw = width * 0.8
        gridh = height * 0.8

        cellw = gridw / cols
        cellh = gridh / rows

        gapx = gridw * 0.015
        gapy = gridh * 0.015

        itemw = cellw - gapx
        itemh = cellh - gapy

        ix = (width - gridw) * 0.5
        iy = (height - gridh) * 2.5


        gridFields = {
            id: "rowList"
            itemComponentName: "movieItem"
            rowFocusAnimationStyle: "fixedFocus"
            drawFocusFeedback: true
            numRows: rows
            translation: [ix, iy]
            itemSize: [gridw, cellh]
            rowItemSize: [itemw, itemh]
            rowItemSpacing: [gapx, 0]
            itemSpacing: [0, gapy]
        }

        movieItemFields = {
            itemw: itemw
            itemh: itemh
        }

        navItemFields = {

        }

        labelFields = {
            width: gridw * 0.75
            translation: [ix, height * 0.2]
            wrap: true
        }


        m.app.append({
            gridFields: gridFields,
            movieItemFields: movieItemFields,
            labelFields: labelFields,
            navItemFields: navItemFields
        })

        m.global.addFields({ app: m.app })
    end if
    return m.app
end function