extends Node2D


var scene = preload("res://CardSprite.tscn")
# Called when the node enters the scene tree for the first time.

func makeRow(suit, yVal):
	for q in range(1, 14):
		var instance = scene.instantiate()
		instance.setSuit(suit)
		instance.setValue(q)
		instance.position = Vector2(25 * (q-1),yVal)
		add_child(instance)
		
func _ready() -> void:
	var deck = Deck.new()
	var card = deck.drawCard()
	var instance = scene.instantiate()
	instance.setSuit(card[1])
	instance.setValue(card[0])
	instance.position = Vector2(0,0)
	add_child(instance)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
