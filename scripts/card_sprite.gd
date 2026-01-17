extends Node2D

func setSuit(suit):
	var newTex = null
	match suit:
		Cards.SUIT.CLUB:
			newTex = preload('res://images/club.png')
		Cards.SUIT.SPADE:
			newTex = preload('res://images/spade.png')
		Cards.SUIT.HEART:
			newTex = preload('res://images/heart.png')
		Cards.SUIT.DIAMOND:
			newTex = preload('res://images/diamond.png')
		_:
			newTex = preload("res://images/error.png")
	$Suit.texture = newTex
	if (suit == Cards.SUIT.HEART or suit == Cards.SUIT.DIAMOND):
		$Number.label_settings = preload("res://assets/CardSpriteRedText.tres")
	else:
		$Number.label_settings = preload("res://assets/CardSpriteBlackText.tres")


const VALUE_POSITIONS = [[-1,0], [-1,-3], [-2,-3], [-3, -3], [-2,-3], [-2,0], [-1,-3], [-2,0], [-2,-3], [-1,-2], [-3,-2], [-2,0], [-3,0]]
func setValue(value):
	$Number.text = Cards.valueToCharacters(value)
	$Number.position = Vector2(VALUE_POSITIONS[value-1][0], VALUE_POSITIONS[value-1][1])
	
