function mathUtils_PI()
    return 3.141592654
end function

function mathUtils_dist(x1, y1, x2, y2)
    dx = x2 - x1
    dy = y2 - y1
    return sqr(dx * dx + dy * dy)
end function