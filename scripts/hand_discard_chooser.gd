extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



var mouseDownPos = null
var scaleFactor = 1.0

func _worldSpaceMouseCoords():
	print("Mouse pos: " + str(get_viewport().get_mouse_position()))
	print("Scale factor: " + str(scaleFactor))
	print("Pos: " + str(self.position))
	var ret = (get_viewport().get_mouse_position() - self.position) / scaleFactor
	print("Ret: " + str(ret))
	return ret
func _commonScrollFunc(zoomIn: bool):
	var oldMousePos = _worldSpaceMouseCoords()
	if zoomIn:
		scaleFactor *= 1.1
	else:
		scaleFactor *= .9
	self.scale = Vector2(1,1) * scaleFactor
	var newMousePos = _worldSpaceMouseCoords()
	self.position -= (oldMousePos - newMousePos) * scaleFactor
	_worldSpaceMouseCoords()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if mouseDownPos != null:
			var deltaPos = get_viewport().get_mouse_position() - mouseDownPos
			self.position += deltaPos
			mouseDownPos = Vector2(0,0)
	else:
		mouseDownPos = null
	if Input.is_action_pressed("mouse_down"):
		mouseDownPos = get_viewport().get_mouse_position()
	if Input.is_action_just_pressed("scroll_down"):
		_commonScrollFunc(false)
	if Input.is_action_just_pressed("scroll_up"):
		_commonScrollFunc(true)
