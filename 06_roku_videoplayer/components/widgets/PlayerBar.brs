sub init()
    m.playerStatus = m.top.findNode("playerStatus")
    m.playerStatus.observeField("pressed", "playerStatusPressed")
    m.progressBarBg = m.top.findNode("progressBarBg")
    m.progressBar = m.top.findNode("progressBar")
    m.currentTime = m.top.findNode("currentTime")
    m.remainingTime = m.top.findNode("remainingTime")
end sub

sub isVisibleChanged()
    m.top.visible = m.top.isVisible
    if m.top.isVisible then
        m.playerStatus.setFocus(true)
    end if
end sub

sub statusChanged()
    status = m.top.status
    if status = "playing"then
        m.playerStatus.text = ">"
    else if status = "paused" then
        m.playerStatus.text = "||"
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press then
        if key = "back" then
            handled = true
            m.top.hideMe = true
        else if key = "play" then
            handled = true
            handlePlayPause()
        end if
    end if
    return handled
end function

sub handlePlayPause()
    if m.top.status = "playing" then
        m.top.control = "pause"
    else if m.top.status = "paused" then
        m.top.control = "resume"
    end if
end sub

sub positionChanged()
    position = m.top.position
    duration = m.top.duration
    percent = (position / duration)
    m.progressBar.width = m.progressBarBg.width * percent
    m.currentTime.text = getFormatedTime(position)
    m.remainingTime.text = "-" + getFormatedTime(duration - position)
end sub

function getFormatedTime(time)
    currentTime = ""
    if time < 60 then
        seconds = time.toStr()
        if time < 10 then
            seconds = "0" + seconds
        end if
        currentTime = "00:00:" + seconds
    else
        minutes = fix(time / 60)
        if minutes >= 60 then
            ' handle hours
        else
            minutesPart = minutes.toStr()
            if minutes < 10 then
                minutesPart = "0" + minutesPart
            end if
            seconds = time - (minutes * 60)
            secondsPart = seconds.toStr()
            if seconds < 10 then
                secondsPart = "0" + secondsPart
            end if
            currentTime = "00:" + minutesPart + ":" + secondsPart
        end if
    end if
    return currentTime
end function

sub playerStatusPressed()
    handlePlayPause()
end sub
