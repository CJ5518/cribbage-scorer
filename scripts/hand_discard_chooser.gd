extends Node2D

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

#all the results of all the different hands
#[[hand: Array, cutStats: Array], [same], [same]]
#cutStats = [[handScore: int, probability: float, cutVal: int], [same], [same]]
var resultsList = []

func printCardArray(arr: Array):
	for q in range(arr.size()):
		print(str(arr[q][0]) + " " + Cards.suitToString(arr[q][1]))

#takes the full results and collapses them
func collapseResults(original: Array) -> Array:
	var ret: Array = []
	var unique = {}
	
	
	for q in range(original.size()):
		var array: Array = original[q]
		if unique.has(array[0]):
			ret[unique[array[0]]][2].append(array[2])
			ret[unique[array[0]]][1] += array[1]
		else:
			unique[array[0]] = ret.size()
			var newObj = array.duplicate_deep()
			newObj[2] = [newObj[2]]
			ret.append(newObj)
	ret.sort_custom(func(a,b): return a[0] > b[0])
	return ret

#Run every possible discard and see what's up
func array6choose4(arr: Array):
	var tmp = arr.duplicate_deep()
	var startAt = 0
	for q in range(0, arr.size()):
		tmp.pop_at(q)
		var tmp2 = tmp.duplicate_deep()
		for i in range(startAt, arr.size() - 1):
			tmp2.pop_at(i)
			resultsList.append([tmp2.duplicate_deep(), collapseResults(evaluateHandChoice(tmp2, arr))])
			tmp2 = tmp.duplicate_deep()
		tmp = arr.duplicate_deep()
		startAt += 1

#woops
func countOccurencesOfValInHand(hand: Array, val: int) -> int:
	var ret = 0
	for q in range(hand.size()):
		var card = hand[q]
		if card[0] == val:
			ret += 1
	return ret

func evaluateHandChoice(hand, originalHand):
	var results = []
	var fourKind = countOccurencesOfValInHand(originalHand, hand[0][0]) == 4
	for q in range(1, 14):
		if fourKind and q == hand[0][0]:
			pass
		else:
			var handScore = Cribbage.countHand(hand, [q,0], false)
			var leftInDeck = 4 - countOccurencesOfValInHand(originalHand, q)
			var probability = leftInDeck / 46.0
			if q == 5:
				print(fourKind)
			results.append([handScore, probability, q])
	return results

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
func drawResults():
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
			for k in range(cutStats[j][2].size()):
				@warning_ignore("int_as_enum_without_match")
				sprite = newCardSprite(cutStats[j][2][k], -1 as Cards.SUIT)
				sprite.position = Vector2((q * 24 * 15) + (k * 24), 100 + (j * 40))
			label = newLabel(str(cutStats[j][0]) + " - " + str(cutStats[j][1] * 100).pad_decimals(1) + "%")
			label.position = sprite.position + Vector2(32,0)

var panAndZoom: PanAndZoom
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panAndZoom = PanAndZoom.new(get_viewport(), self)
	array6choose4(testHand)
	drawResults()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	panAndZoom.onProcess()
	
