extends Node2D

var suit = 0
var value = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("card_viewer_suit_down"):
		if suit == 0: suit = 3
		else: suit -= 1
		changeCard()
	if Input.is_action_just_pressed("card_viewer_suit_up"):
		if suit == 3: suit = 0
		else: suit += 1
		changeCard()
	if Input.is_action_just_pressed("card_viewer_value_up"):
		if value == 13: value = 1
		else: value += 1
		changeCard()
	if Input.is_action_just_pressed("card_viewer_value_down"):
		if value == 1: value = 13
		else: value -= 1
		changeCard()


func changeCard():
	$CardSprite.setSuit(suit)
	$CardSprite.setValue(value)
