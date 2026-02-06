extends Node2D

var cardSprite = preload("res://scenes/CardSprite.tscn")

#Does not include the cut card
var cardSprites

var deck
var thisHandsScore = 0
var hand
var cutCard
enum States {
	Waiting,
	Scoring
}

signal correctAnswer(hand: Array, cutCard: Array, time: float, score: int)
signal wrongAnswer(hand: Array, cutCard: Array, time: float, score: int)

var ourState: States = States.Waiting

var timerStart = 0
var numsJustPressed = []

func setCard(obj, arr):
	obj.setValue(arr[0])
	obj.setSuit(arr[1])

func randomCards():
	deck.reset()
	hand = []
	for q in range(6):
		hand.append(deck.drawCard())
	var handChoicesPlural = CribbageThinker.pickGoodChoicesForDiscard(hand)
	#pick one of the potential several hand choices
	var handChoice = handChoicesPlural[randi() % handChoicesPlural.size()]
	for q in range(cardSprites.size()):
		setCard(cardSprites[q], handChoice[q])
	cutCard = deck.drawCard()
	setCard($CutCard, cutCard)
	thisHandsScore = Cribbage.countHand(handChoice, cutCard, false)

func _ready() -> void:
	cardSprites = [$CardSprite, $CardSprite2, $CardSprite3, $CardSprite4]
	$Control/MenuButton.button_down.connect(
		func(): get_tree().quit()
	)
	for q in range(10):
		numsJustPressed.append(false)
	deck = Deck.new()
	randomCards()

#Could've done classes but with 2 states it wasn't really a huge deal imo
func exitWaiting():
	$Control/PressSpaceToStart.visible = false
func enterWaiting():
	ourState = States.Waiting
	$Control/PressSpaceToStart.visible = true

func enterScoring():
	ourState = States.Scoring
	numsJustPressed.fill(false)
	$Control/Timer.visible = true
	$Control/ScoreEntry.visible = true
	timerStart = Time.get_unix_time_from_system()
	randomCards()
func exitScoring():
	$Control/Timer.visible = false
	$Control/ScoreEntry.visible = false
	$Control/ScoreEntry.text = ""

var scoreString = ""
func processScoring():
	$Control/Timer.text = str(Time.get_unix_time_from_system() - timerStart).pad_decimals(2)
	#check if the user has entered anything
	for q in range(numsJustPressed.size()):
		var numPressed = numsJustPressed[q]
		if numPressed:
			numsJustPressed[q] = false
			scoreString += str(q)
			break
	$Control/ScoreEntry.text = scoreString
	if scoreString.length() == 2:
		var scoreGuess = int(scoreString)
		scoreString = ""
		if scoreGuess == thisHandsScore:
			correctAnswer.emit(hand, cutCard, Time.get_unix_time_from_system() - timerStart, scoreGuess)
			exitScoring()
			enterWaiting()
		else:
			wrongAnswer.emit(hand, cutCard, Time.get_unix_time_from_system() - timerStart, scoreGuess)

func processWaiting():
	if Input.is_action_just_released("readyToScore"):
		exitWaiting()
		enterScoring()

func _process(_delta: float) -> void:
	match ourState:
		States.Waiting:
			processWaiting()
		States.Scoring:
			processScoring()


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_0:
			numsJustPressed[0] = true
		if event.keycode == KEY_1:
			numsJustPressed[1] = true
		if event.keycode == KEY_2:
			numsJustPressed[2] = true
		if event.keycode == KEY_3:
			numsJustPressed[3] = true
		if event.keycode == KEY_4:
			numsJustPressed[4] = true
		if event.keycode == KEY_5:
			numsJustPressed[5] = true
		if event.keycode == KEY_6:
			numsJustPressed[6] = true
		if event.keycode == KEY_7:
			numsJustPressed[7] = true
		if event.keycode == KEY_8:
			numsJustPressed[8] = true
		if event.keycode == KEY_9:
			numsJustPressed[9] = true
