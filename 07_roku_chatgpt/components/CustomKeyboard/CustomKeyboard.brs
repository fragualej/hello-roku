sub init()
    m.appColors = getAppColors()
    m.top.keyGrid.keyDefinitionUri = "pkg:/components/CustomKeyboard/CustomKeyboard.json"
    m.top.keyGrid.vertWrap = true

    keyboardPalette = createObject("roSGNode", "RSGPalette")
    keyboardPalette.colors = {
        "KeyboardColor": m.appColors.BACKGROUND_COLOR
        "PrimaryTextColor": m.appColors.LIGHT_BLUE_FOCUS,
        "FocusColor": m.appColors.LIGHT_BLUE_FOCUS,
        "FocusItemColor": m.appColors.BACKGROUND_COLOR
    }
    m.top.keyGrid.palette = keyboardPalette

    m.top.textEditBox.voiceEnabled = true
    m.top.textEditBox.maxTextLength = 30
    m.top.textEditBox.clearOnDownKey = true
    m.top.textEditBox.hintText = "Please, select one topic"

    'TextEditBox UI"
    m.top.textEditBox.hintTextColor = m.appColors.LIGHT_BLUE_FOCUS
    m.top.textEditBox.textColor = m.appColors.LIGHT_BLUE_FOCUS
    m.top.textEditBox.fontUri = "font:MediumBoldSystemFont"
    m.top.textEditBox.fontSize = 38

    ' 'TextEditBox VoiceControls
    m.top.textEditBox.inheritParentOpacity = false
    m.top.textEditBox.inheritParentTransform = false
    m.top.textEditBox.translation = [560, 560]

    'Input Field UI
    inputBox = m.top.textEditBox.getChildren(-1, 0)
    m.input = inputBox[4]
    m.input.blendColor = m.appColors.LIGHT_BLUE

    ' 'Input Focus UI
    inputBitmap = m.input.getChildren(-1, 0)
    inputBitmapBox = inputBitmap[0]
    inputBitmapBox.blendColor = m.appColors.LIGHT_BLUE
end sub