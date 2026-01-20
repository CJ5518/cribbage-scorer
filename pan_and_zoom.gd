extends Node2D

class_name PanAndZoom

var mouseDownPos
var scaleFactor
var viewport: Viewport
var rootNode: Node2D
func _init(viewportObj: Viewport, root: Node2D) -> void:
	mouseDownPos = null
	scaleFactor = 1.0
	viewport = viewportObj
	rootNode = root
	
	
func worldSpaceMouseCoords():
	return (viewport.get_mouse_position() - rootNode.position) / scaleFactor
func _commonScrollFunc(zoomIn: bool):
	var oldMousePos = worldSpaceMouseCoords()
	if zoomIn:
		scaleFactor *= 1.1
	else:
		scaleFactor *= .9
	rootNode.scale = Vector2(1,1) * scaleFactor
	rootNode.position -= (oldMousePos - worldSpaceMouseCoords()) * scaleFactor
	
func onProcess():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if mouseDownPos != null:
			var deltaPos = viewport.get_mouse_position() - mouseDownPos
			rootNode.position += deltaPos
			mouseDownPos = Vector2(0,0)
	else:
		mouseDownPos = null
	if Input.is_action_pressed("mouse_down"):
		mouseDownPos = viewport.get_mouse_position()
	if Input.is_action_just_pressed("scroll_down"):
		_commonScrollFunc(false)
	if Input.is_action_just_pressed("scroll_up"):
		_commonScrollFunc(true)
