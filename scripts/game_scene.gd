extends Node2D

var cardSprite = preload("res://scenes/CardSprite.tscn")

#Does not include the cut card
var cardSprites

var deck

func setCard(obj, arr):
	obj.setValue(arr[0])
	obj.setSuit(arr[1])

func randomCards():
	deck.reset()
	var hand = []
	for q in range(6):
		hand.append(deck.drawCard())
		print(hand[q][0])
	print("---")
	var handChoicesPlural = CribbageThinker.pickGoodChoicesForDiscard(hand)
	var handChoice = handChoicesPlural[randi() % handChoicesPlural.size()]
	for q in range(cardSprites.size()):
		setCard(cardSprites[q], handChoice[q])
	setCard($CutCard, deck.drawCard())

func _ready() -> void:
	cardSprites = [$CardSprite, $CardSprite2, $CardSprite3, $CardSprite4]
	deck = Deck.new()
	randomCards()
	$Control/MenuButton.pressed.connect(randomCards)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
