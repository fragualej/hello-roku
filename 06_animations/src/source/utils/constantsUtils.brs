function constantsUtil_get()
    constants = m.global.constants
    if constants = invalid
        constants = createObject("roSGNode", "node")
        api = _setApi()
        colors = _setColors()
        fonts = _setFonts()
        styles = _setStyles(fonts, colors)
        constants.addFields({
            api: _setApi(),
            colors: colors,
            fonts: fonts,
            styles: styles
        })

        m.global.addFields({ constants: constants })
    end if
    return constants
end function

function _setColors()
    colors = createObject("roSGNode", "node")
    colors.addFields({
        "BLACK": "#000000",
        "BLUE": "#0000FF",
        "GREEN": "#00FF00",
        "RED": "#FF0000",
        "YELLOW": "#FFFF00",
        "ORANGE": "#FFA500",
        "PURPLE": "#800080",
        "PINK": "#FFC0CB",
        "BROWN": "#A0522D",
        "GRAY": "#808080",
        "TEAL": "#008080",
        "WHITE": "#FFFFFF"
    })
    return colors
end function

function _setApi()
    ' Load config from config.json
    config = ReadAsciiFile("pkg:/source/config/config.json")
    configJson = ParseJson(config)

    api = createObject("roSGNode", "node")
    if configJson <> invalid and configJson.api <> invalid
        api.addFields({
            "TMDB_API_BASE_URL": configJson.api.baseUrl,
            "TMDB_API_ENDPOINT": configJson.api.endpoint,
            "TMDB_API_IMAGE_URL": configJson.api.imageUrl,
            "TMDB_API_KEY": configJson.api.key,
            "TMDB_TOKEN": configJson.api.token
        })
    else
        print "Error: Could not load config.json"
    end if
    return api
end function

function _setFonts()
    fonts = createObject("roSGNode", "node")
    uri = createObject("roSGNode", "node")
    size = createObject("roSGNode", "node")

    uri.addFields({
        "BOLD": "font:BoldSystemFontFile",
        "DEFAULT": "font:SystemFontFile"
    })
    x = 8
    size.addFields({
        "H1": x * Sqr(2) ^ 6,
        "H2": x * Sqr(2) ^ 5,
        "H3": x * Sqr(2) ^ 4,
        "H4": x * Sqr(2) ^ 3,
        "H5": x * Sqr(2) ^ 2,
        "H6": x * Sqr(2) ^ 1
    })

    fonts.addFields({
        uri: uri,
        size: size
    })

    return fonts
end function

function _setStyles(fonts, colors)
    styles = createObject("roSGNode", "node")
    styles.addFields({
        multiStyles: {
            "h1": {
                "fontSize": fonts.size.H1,
                "fontUri": fonts.uri.DEFAULT,
                "color": colors.WHITE
            },
            "h2": {
                "fontSize": fonts.size.H2,
                "fontUri": fonts.uri.DEFAULT,
                "color": colors.WHITE
            },
            "h3": {
                "fontSize": fonts.size.H3,
                "fontUri": fonts.uri.DEFAULT,
                "color": colors.WHITE
            },
            "h4": {
                "fontSize": fonts.size.H4,
                "fontUri": fonts.uri.DEFAULT,
                "color": colors.WHITE
            },
            "h5": {
                "fontSize": fonts.size.H5,
                "fontUri": fonts.uri.DEFAULT,
                "color": colors.WHITE
            },
            "h6": {
                "fontSize": fonts.size.H6,
                "fontUri": fonts.uri.DEFAULT,
                "color": colors.WHITE
            }
        }
    })
    return styles
end function