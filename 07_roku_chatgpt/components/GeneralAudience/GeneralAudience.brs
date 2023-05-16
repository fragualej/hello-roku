sub init()
    m.appColors = getAppColors()
    m.CustomKeyboard = m.top.findNode("CustomKeyboard")
    m.CustomKeyboard.translation = [ 200 , 550]   
    m.CustomKeyboard.text = ""

    m.Rectangle1 = m.top.findNode("Rectangle1")
    m.Rectangle1.color = m.appColors.BACKGROUND_COLOR
    m.Rectangle1.width = 1920
    m.Rectangle1.height = 1080
    m.Rectangle1.translation = [0,0]

    m.Rectangle2 = m.top.findNode("Rectangle2")
    m.Rectangle2.color = m.appColors.LIGHT_BLUE
    m.Rectangle2.width = 1200
    m.Rectangle2.height = 980
    m.Rectangle2.translation = [360, 50]

    m.Rectangle3 = m.top.findNode("Rectangle3")
    m.Rectangle3.color = m.appColors.BACKGROUND_COLOR
    m.Rectangle3.width = 400
    m.Rectangle3.height = 100
    m.Rectangle3.translation = [200, -40]

    m.Rectangle4 = m.top.findNode("Rectangle4")
    m.Rectangle4.color = m.appColors.WHITE
    m.Rectangle4.width = 800
    m.Rectangle4.height = 400
    m.Rectangle4.translation = [200, 100]

    m.SimpleLabel = m.top.findNode("SimpleLabel")
    m.SimpleLabel.color = m.appColors.WHITE
    m.SimpleLabel.translation = [120, 30]
    m.SimpleLabel.fontUri = "font:MediumBoldSystemFont"
    m.SimpleLabel.text = "ASK PBS"
end sub
function onKeyEvent(key as string, press as boolean) as boolean
    if key = "OK" and m.CustomKeyboard.text.len() > 1
        updateQuestionLabel(m.CustomKeyboard.text)
        return true
    end if
end function

function updateQuestionLabel(label as string)
    m.Question = m.top.findNode("Question")
    m.Question.text = label
    m.Question.color = m.appColors.LIGHT_BLUE
    m.Question.fontUri = "font:MediumBoldSystemFont"
    updateAnswerLabel()
end function

function updateAnswerLabel()
    m.Answer = m.top.findNode("Answer")
    m.Answer.text = "Your answer here"
    m.Answer.color = m.appColors.BACKGROUND_COLOR
    m.Answer.fontUri = "font:MediumBoldSystemFont"
end function