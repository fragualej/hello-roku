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

        ix = (width - gridw) * 1.5
        iy = (height - gridh) * 2.5


        gridFields = {
            id: "rowList"
            itemComponentName: "baseItem"
            rowFocusAnimationStyle: "fixedFocus"
            drawFocusFeedback: true
            numRows: rows
            translation: [ix, iy]
            itemSize: [gridw, cellh]
            rowItemSize: [itemw, itemh]
            rowItemSpacing: [gapx, 0]
            itemSpacing: [0, gapy]
        }

        itemFields = {
            posterFields: {
                id: "poster"
                width: itemw
                height: itemh
            }
        }

        labelFields = {
            width: gridw * 0.75
            heigth: cellh * 0.5
            translation: [ix, height * 0.1]
            wrap: true
        }


        m.app.append({
            gridFields: gridFields,
            itemFields: itemFields,
            labelFields: labelFields
        })

        m.global.addFields({ app: m.app })
    end if
    return m.app
end function