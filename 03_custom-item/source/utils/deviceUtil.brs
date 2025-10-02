function deviceUtil_getResolution() as object
    di = createObject("roDeviceInfo")
    return di.getUIResolution()
end function