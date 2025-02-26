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
        "BLACK": "#000000"
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
    api = createObject("roSGNode", "node")
    api.addFields({
        "TMDB_API_BASE_URL": "https://api.themoviedb.org/3",
        "TMDB_API_ENDPOINT": "https://api.themoviedb.org/3/trending/movie/week?api_key=",
        "TMDB_API_IMAGE_URL": "https://image.tmdb.org/t/p/w500",
        "TMDB_API_KEY": "558e2410c2be44f6e971c2b2c8cf64d0"
        "TMDB_TOKEN": "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NThlMjQxMGMyYmU0NGY2ZTk3MWMyYjJjOGNmNjRkMCIsIm5iZiI6MTYyNjM3Nzg0OC44OTIsInN1YiI6IjYwZjA4ZTc4NmNmM2Q1MDA1ZGE0OGM1YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.n0CtmS2w8DLLI9nS_u159kw6LbEdDPqWzjgEtidf9Nk"
    })
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
        "H1": x * Sqr(2) ^ 6
        "H2": x * Sqr(2) ^ 5
        "H3": x * Sqr(2) ^ 4
        "H4": x * Sqr(2) ^ 3
        "H5": x * Sqr(2) ^ 2
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
                "fontSize": fonts.size.H1
                "fontUri": fonts.uri.DEFAULT
                "color": colors.BLACK
            }
            "h2": {
                "fontSize": fonts.size.H2
                "fontUri": fonts.uri.DEFAULT
                "color": colors.BLACK
            }
            "h3": {
                "fontSize": fonts.size.H3
                "fontUri": fonts.uri.DEFAULT
                "color": colors.BLACK
            }
            "h4": {
                "fontSize": fonts.size.H4
                "fontUri": fonts.uri.DEFAULT
                "color": colors.BLACK
            }
            "h5": {
                "fontSize": fonts.size.H5
                "fontUri": fonts.uri.DEFAULT
                "color": colors.BLACK
            }
            "h6": {
                "fontSize": fonts.size.H6
                "fontUri": fonts.uri.DEFAULT
                "color": colors.BLACK
            }
        }
    })
    return styles
end function