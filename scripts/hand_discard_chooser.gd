extends Node2D

var panAndZoom: PanAndZoom
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panAndZoom = PanAndZoom.new(get_viewport(), self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	panAndZoom.onProcess()
	
