sub nodeUtil_createAbstractNode(p_scene as object, p_resolution as object, p_text = "" as string)
    x = p_resolution.width * 0.03
    y = p_resolution.width * 0.03

    abstractNode = createObject("roSGNode", "abstractNode")
    abstractNode.content = { text: p_text, fontSize: p_resolution.height * 0.025 }
    abstractNode.translation = [x, y]

    p_scene.appendChild(abstractNode)
end sub