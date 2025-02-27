function constantsUtil_get()
    m.constants = m.global.constants
    if m.constants = invalid
        m.constants = createObject("roSGNode", "node")

        colors = createObject("roSGNode", "node")
        fonts = createObject("roSGNode", "node")
        api = createObject("roSGNode", "node")
        colors.addFields({
            "RED": "#FF0000",
            "GREEN": "#00FF00",
            "BLUE": "#0000FF",
            "YELLOW": "#FFFF00",
            "ORANGE": "#FFA500",
            "PURPLE": "#800080",
            "PINK": "#FFC0CB",
            "BROWN": "#A0522D",
            "GRAY": "#808080",
            "TEAL": "#008080"
        })

        fonts.addFields({
            "FONT_SIZE_LARGE": 32,
            "FONT_SIZE_MEDIUM": 24,
            "FONT_SIZE_SMALL": 18
        })

        api.addFields({
            "TEST_API_ENDPOINT": "https://api.themoviedb.org/3/trending/movie/week?api_key=",
            "TEST_API_IMAGE_URL": "https://image.tmdb.org/t/p/w500",
            "TEST_API_KEY": "558e2410c2be44f6e971c2b2c8cf64d0"
        })
        m.constants.addFields({
            api: api,
            colors: colors,
            fonts: fonts
        })
        m.global.addFields({ constants: m.constants })
        print "m.constants: ", m.constants.api, m.constants.colors, m.constants.fonts
    end if
    return m.constants
end function
