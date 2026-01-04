extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$QuitButton.button_down.connect(
		func(): get_tree().quit()
	)
	$StartButton.button_down.connect(
		func(): get_tree().change_scene_to_file("res://scenes/test_scene.tscn")
	)
