function app()
    m.app = m.global.app

    if m.app = invalid
        m.app = {}
        gridParams = { rows: 2, cols: 5 }
        navParams = { rows: 1, cols: 7 }
        m.app.append({
            gridFields: _setGridFields(gridParams)
            navFields: _setNavFields(navParams)
        })

        m.global.addFields({ app: m.app })
    end if
    return m.app
end function

function _setGridFields(p_params)
    return gridUtil_setGrid(p_params.rows, p_params.cols)
end function

function _setNavFields(p_params)
    return gridUtil_setGrid(p_params.rows, p_params.cols)
end function