sub init()
    m.timer = m.top.findNode("timer")
    m.timer.ObserveField("fire", "onFire")
    m.timer.control = "start"
end sub

sub onFire()
    m.top.state = "finish"
end sub