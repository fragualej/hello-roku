function gridUtil_getGridValues(p_rows, p_cols, p_resolution)
    width = p_resolution.width
    height = p_resolution.height

    gridw = width * 0.8
    gridh = height * 0.8

    cellw = gridw / p_cols
    cellh = gridh / p_rows

    gapx = gridw * 0.015
    gapy = gridh * 0.015

    itemw = cellw - gapx
    itemh = cellh - gapy

    ix = (width - gridw) * 0.5
    iy = (height - gridh) * 0.5

    return {
        gridw: gridw,
        gridh: gridh,
        cellw: cellw,
        cellh: cellh,
        gapx: gapx,
        gapy: gapy,
        itemw: itemw,
        itemh: itemh
        ix: ix,
        iy: iy
    }
end function