extends Object

class_name Deck

#do not edit this one please :0
static var staticDeck = null

var _deck

func _init() -> void:
	if staticDeck == null:
		initStaticDeck()
	_deck = staticDeck.duplicate(true)

func drawCard():
	var randy = randi()
	return _deck.pop_at(randy % _deck.size())

static func initStaticDeck():
	staticDeck = []
	for q in range(1,14):
		staticDeck.append([q,Cards.SUIT.CLUB])
		staticDeck.append([q,Cards.SUIT.HEART])
		staticDeck.append([q,Cards.SUIT.DIAMOND])
		staticDeck.append([q,Cards.SUIT.SPADE])
