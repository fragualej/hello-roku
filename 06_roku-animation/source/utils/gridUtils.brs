function gridUtil_getGridValues(p_rows, p_cols, p_resolution, p_grid_factor = 0.8, p_gap_factor = 0.01) as object
    width = p_resolution.width
    height = p_resolution.height

    gridw = width * p_grid_factor
    gridh = height * p_grid_factor

    cellw = gridw / p_cols
    cellh = gridh / p_rows

    gapx = gridw * p_gap_factor
    gapy = gridh * p_gap_factor

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
        itemh: itemh,
        ix: ix,
        iy: iy
    }
end function