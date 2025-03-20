function gridUtil_setGrid(p_rows, p_cols, isSimetric = false, p_grid_factor = 0.8, p_gap_factor = 0.05) as object
    res = deviceUtil_getUIResolution()

    width = res.width
    height = res.height

    gridw = width * p_grid_factor
    gridh = height * p_grid_factor

    if isSimetric then gridw = gridh

    cellw = gridw / p_cols
    cellh = gridh / p_rows

    gapx = cellw * p_gap_factor
    gapy = cellh * p_gap_factor

    itemw = cellw - gapx
    itemh = cellh - gapy

    ix = gridUtil_hAlignToCenter(width, gridw)
    iy = gridUtil_vAlignToCenter(height, gridh)

    return {
        rows: p_rows,
        cols: p_cols,
        gridw: gridw,
        gridh: gridh,
        cellw: cellw,
        cellh: cellh,
        itemw: itemw,
        itemh: itemh,
        gapx: gapx,
        gapy: gapy,
        ix: ix,
        iy: iy
    }
end function

function gridUtil_hAlignToCenter(p_view_width, p_target_width)
    return (p_view_width - p_target_width) * 0.5
end function

function gridUtil_vAlignToCenter(p_view_height, p_target_height)
    return (p_view_height - p_target_height) * 0.5
end function