extends Node2D

var cardSprite = preload("res://scenes/CardSprite.tscn")
#29 pixels wide, scaled up by a factor of 8
const cardWidth = 25 * 8

#cut card is last in the array
var cardSprites = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Make the card nodes
	var width = cardWidth * 4
	@warning_ignore("integer_division")
	var startAt = (1920 / 2) - (width / 2.0)
	for q in range(4):
		var instance = cardSprite.instantiate()
		cardSprites.append(instance)
		instance.position = Vector2(startAt + (q * cardWidth),600)
		add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
