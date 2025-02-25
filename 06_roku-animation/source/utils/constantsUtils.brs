function constantsUtil_get()
    constants = m.global.constants
    if constants = invalid
        constants = createObject("roSGNode", "node")
        constants.addFields({
            api: _setApi(),
            colors: _setColors(),
            fonts: _setFonts(),
            styles: _setStyles(),
            tts: _setTTS()
        })
        m.global.addFields({ constants: constants })
    end if
    return constants
end function

function _setColors()
    colors = createObject("roSGNode", "node")
    colors.addFields({
        "BLACK": "#000000"
        "RED": "#FF0000",
        "GREEN": "#00FF00",
        "BLUE": "#0000FF",
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
        "TEST_API_ENDPOINT": "https://api.themoviedb.org/3/trending/movie/week?api_key=",
        "TEST_API_IMAGE_URL": "https://image.tmdb.org/t/p/w500",
        "TEST_API_KEY": "558e2410c2be44f6e971c2b2c8cf64d0"
    })
    return api
end function

function _setFonts()
    fonts = createObject("roSGNode", "node")
    size = createObject("roSGNode", "node")
    uri = createObject("roSGNode", "node")
    size.addFields({
        "LARGE": 54,
        "MEDIUM": 40,
        "SMALL": 27
    })
    uri.addFields({
        "BOLD": "font:BoldSystemFontFile",
        "SYSTEM": "font:SystemFontFile",
    })
    fonts.addFields({
        size: size,
        uri: uri
    })
    return fonts
end function

function _setStyles()
    styles = createObject("roSGNode", "node")
    styles.addFields({
        width: 1920
        height: 1080
    })
    return styles
end function

function _setTTS()
    ttsTexts = createObject("roSGNode", "tts")
    return ttsTexts
end function