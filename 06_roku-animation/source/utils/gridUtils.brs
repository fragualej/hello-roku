function gridUtil_setGrid(p_rows, p_cols, isSimetric = false, p_grid_factor = 0.8, p_gap_factor = 0.01) as object
    p_resolution = deviceUtil_getUIResolution()

    width = p_resolution.width
    height = p_resolution.height

    gridw = width * p_grid_factor
    gridh = height * p_grid_factor

    if isSimetric then gridw = gridh

    cellw = gridw / p_cols
    cellh = gridh / p_rows

    gapx = gridw * p_gap_factor
    gapy = gridh * p_gap_factor

    itemw = cellw - gapx
    itemh = cellh - gapy

    ix = gridUtil_hAlignToCenter(width, gridw)
    iy = gridUtil_vAlignToCenter(height, gridh)

    return {
        gridw: gridw,
        gridh: gridh,
        cellw: cellw,
        cellh: cellh,
        gapx: gapx,
        gapy: gapy,
        itemw: itemw,
        itemh: itemh,
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