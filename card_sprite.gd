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

func setValue(value):
	$Number.text = Cards.valueToCharacters(value)
