function app()
    m.app = m.global.app

    if m.app = invalid
        m.app = {}
        resolution = deviceUtil_getUIResolution()
        m.app.append({
            gridFields: _setGridFields(resolution)
            navFields: _setNavFields(resolution)
        })

        m.global.addFields({ app: m.app })
    end if
    return m.app
end function

function _setGridFields(p_resolution)
    return gridUtil_getGridValues(3, 3)
end function

function _setNavFields(p_resolution)
    return gridUtil_getGridValues(1, 7)
end function