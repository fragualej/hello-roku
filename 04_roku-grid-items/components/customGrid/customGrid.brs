sub init()
    print "CustomGrid - Init()"
    m.group = m.top.findNode("group")
    m.top.observeField("focusedChild","onFocusedChild")
    setGrid()
end sub

sub onFocusedChild()
    if m.top.hasFocus()
        m.top.indexFocused = 0
    end if
end sub

sub setGrid()
    r = getUIResolution()

    gridw = r.height * 0.6
    gridh = r.height * 0.6

    ix = (r.width  - gridw) * 0.5
    iy = (r.height - gridh) * 0.95

    rows = 4
    cols = 4

    numItems = rows * cols

    cellw = gridw / rows
    cellh = gridh / cols

    gapx = cellw * 0.1
    gapy = cellw * 0.1

    itemw = cellw - gapx
    itemh = cellh - gapy

    setLabels(ix, iy, gridw, gridh)

    numPad = "123+456-789*C0=/".split("")

    for i = 0 to numItems - 1
        row = fix(i / rows)
        col = i mod cols

        x = ix + col * (itemw + gapx) + gapx * 0.5
        y = iy + row * (itemh + gapy) + gapy * 0.5

        item = createObject("roSGNode", "customItem")
        item.translation = [x, y]
        item.content = {
            width: itemw
            height: itemh
            text: numPad[i]
            rectColor: "#FFFFFF"
            textColor: "#000000"
            fontSize: cellh * 0.4
        }
        m.group.appendChild(item)
    end for

    m.top.numRows = rows
    m.top.numCols = cols
end sub

sub setLabels(ix as integer, iy as integer, gridw as integer, gridh as integer)
    m.inputLabel = createObject("roSGNode", "customItem")
    m.inputLabel.content = {
        width: gridw
        height: gridh * 0.2
        rectColor: "#FFFFFF"
        textColor: "#000000"
        fontSize: gridh * 0.1
    }
    m.inputLabel.translation = [ix, gridh * 0.1]

    m.outputLabel = createObject("roSGNode", "customItem")
    m.outputLabel.content = {
        width: gridw
        height: gridh * 0.2
        rectColor: "#FFFFFF"
        textColor: "#000000"
        fontSize: gridh * 0.1
    }
    m.outputLabel.translation = [ix, gridh * 0.35]

    m.top.appendChild(m.inputLabel)
    m.top.appendChild(m.outputLabel)
end sub

sub onItemIndexSet()
    m.top.indexFocused = m.top.numCols * m.top.rowIndex + m.top.colIndex
end sub

sub onItemIndexFocused(event as object)
    index = event.getData()
    item = m.group.getChild(index)
    item.setFocus(true)
    m.inputLabel.text = item.text
    print "itemFocused:  ", m.top.indexFocused, item.text
end sub

sub onItemIndexSelected(event as object)
    index = event.getData()
    item = m.group.getChild(index)
    m.outputLabel.text = item.text
    print "itemSelected: ", m.top.indexSelected, item.text
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "left"
            if m.top.colIndex > 0 then m.top.colIndex--
            handled = true
        else if key = "right"
            if m.top.colIndex < m.top.numCols - 1 then m.top.colIndex++
            handled = true
        else if key = "up"
            if m.top.rowIndex > 0 then m.top.rowIndex--
            handled = true
        else if key = "down"
            if m.top.rowIndex < m.top.numRows - 1 then m.top.rowIndex++
            handled = true
        else if key = "OK"
            m.top.indexSelected = m.top.indexFocused
            handled = true
        end if
    end if
    return handled
end function
