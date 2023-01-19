function getUIResolution() as object
    di = createObject("roDeviceInfo")
    return di.getUIResolution()
end function