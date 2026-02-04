extends Node2D


#TODO:
#I wanna have most of this junk in a different file, call it cribbage engine or something
#Then this code just calls into that, and can do more important things like allow for selecting the
#cards and such. Also we could collapse in the original function I think? Also names are bad
#lots to do!


#Example hand that has a very obvious play
var testHand = [
	[5, Cards.SUIT.CLUB],
	[5, Cards.SUIT.SPADE],
	[5, Cards.SUIT.HEART],
	[5, Cards.SUIT.DIAMOND],
	[1, Cards.SUIT.CLUB],
	[2, Cards.SUIT.CLUB]
]

const CardSprite = preload("res://scenes/CardSprite.tscn")

func newCardSprite(val: int, suit: Cards.SUIT) -> Node2D:
	var ret = CardSprite.instantiate()
	ret.setSuit(suit)
	ret.setValue(val)
	add_child(ret)
	return ret
func newLabel(text: String) -> Label:
	var ret: Label = $LabelTemplate.duplicate()
	ret.visible = true
	ret.text = text
	add_child(ret)
	return ret

#draws everything
func drawResults(resultsList: Array):
	#draw the starting hand
	var sprite
	var label
	for q in range(testHand.size()):
		sprite = newCardSprite(testHand[q][0], testHand[q][1])
		sprite.position = Vector2(q * 24, 0.0)
		
	#draw all the possibilites of 4 cards
	for q in range(resultsList.size()):
		var results = resultsList[q]
		var hand = results[0]
		#every choice of 4 cards
		for i in range(hand.size()):
			sprite = newCardSprite(hand[i][0], hand[i][1])
			sprite.position = Vector2((i * 24) + (q * 24 * 15), 50)
		#every choice of cut card
		var cutStats = results[1]
		for j in range(cutStats.size()):
			var thoughts = cutStats[j]
			for k in range(thoughts.cutVals.size()):
				@warning_ignore("int_as_enum_without_match")
				sprite = newCardSprite(thoughts.cutVals[k], -1 as Cards.SUIT)
				sprite.position = Vector2((q * 24 * 15) + (k * 24), 100 + (j * 40))
			label = newLabel(str(thoughts.handScore) + " - " + str(thoughts.probability * 100).pad_decimals(1) + "%")
			label.position = sprite.position + Vector2(32,0)

var panAndZoom: PanAndZoom
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panAndZoom = PanAndZoom.new(get_viewport(), self)
	drawResults(CribbageThinker.getFullThoughtsOn6CardHand(testHand))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	panAndZoom.onProcess()
	
