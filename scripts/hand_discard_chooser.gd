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

func printCardArray(arr: Array):
	for q in range(arr.size()):
		print(str(arr[q][0]) + " " + Cards.suitToString(arr[q][1]))

#Run every possible discard and see what's up
func array6choose4(arr: Array):
	var tmp = arr.duplicate_deep()
	var startAt = 0
	for q in range(0, arr.size()):
		tmp.pop_at(q)
		var tmp2 = tmp.duplicate_deep()
		for i in range(startAt, arr.size() - 1):
			tmp2.pop_at(i)
			printCardArray(tmp2)
			evaluateHandChoice(tmp2, arr)
			tmp2 = tmp.duplicate_deep()
		tmp = arr.duplicate_deep()
		startAt += 1
	
func countOccurencesOfValInHand(hand: Array, val: int) -> int:
	var ret = 0
	for q in range(0, hand.size()):
		if hand[q][0] == val:
			ret += 1
	return ret

func evaluateHandChoice(hand, originalHand):
	var results
	var fourKind = countOccurencesOfValInHand(hand, hand[0][0]) == 4
	for q in range(1, 14):
		if fourKind and q == hand[0][0]:
			pass
		else:
			if fourKind and q == 6:
				pass
			var handScore = Cribbage.countHand(hand, [q,0], false)
			var leftInDeck = 4 - countOccurencesOfValInHand(originalHand, q)
			var probability = leftInDeck / 46.0
			results = [handScore, probability]
			print("Cut val: " + str(q))
			print(str(handScore) + " " + str(probability))
	return results

var panAndZoom: PanAndZoom
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panAndZoom = PanAndZoom.new(get_viewport(), self)
	array6choose4(testHand)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	panAndZoom.onProcess()
	
