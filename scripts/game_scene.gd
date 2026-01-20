extends Node2D

var cardSprite = preload("res://scenes/CardSprite.tscn")
#29 pixels wide, scaled up by a factor of 8
const cardWidth = 25 * 8

#cut card is last in the array
var cardSprites = []

var deck

func setCard(obj, arr):
	obj.setValue(arr[0])
	obj.setSuit(arr[1])

func randomCards():
	deck.reset()
	setCard($CardSprite, deck.drawCard())
	setCard($CardSprite2, deck.drawCard())
	setCard($CardSprite3, deck.drawCard())
	setCard($CardSprite4, deck.drawCard())
	setCard($CutCard, deck.drawCard())

func _ready() -> void:
	deck = Deck.new()
	randomCards()
	$Control/MenuButton.pressed.connect(randomCards)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
