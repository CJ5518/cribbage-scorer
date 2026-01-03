extends Object

class_name Cribbage

#removes all occurences of item from arr, and returns how many there were
static func _removeAllFromArray(arr: Array, item: int) -> int:
	var count: int = 0
	while true:
		var oldSize: int = arr.size()
		arr.erase(item)
		if oldSize == arr.size():
			break
		else:
			count += 1
	return count

static func countFlush(hand: Array, cut: Array, crib: bool) -> int:
	var score: int = 0
	
	var flushSuit = hand[0][1]
	var isFourCardFlush: bool = true
	for q in range(1,hand.size()):
		if flushSuit != hand[q][1]:
			isFourCardFlush = false
			break
	if isFourCardFlush and cut[1] == flushSuit:
		score += 5
	elif isFourCardFlush and not crib:
		score += 4
	return score
	
static func countNobs(hand: Array, cut: Array, _crib: bool) -> int:
	for q in range(0, hand.size()):
		if hand[q][0] == 11 and hand[q][1] == cut[1]:
			return 1
	return 0
	
static func countPairs(hand: Array, cut: Array, _crib: bool) -> int:
	var score: int = 0
	
	var values = []
	for q in range(hand.size()):
		values.append(hand[q][0])
	values.append(cut[0])
	values.sort()
	
	#pairs
	var old = -1
	var pairCount = 0
	#run an extra time because we need to run the else condition again at the end
	#I suppose a different type of loop could be applicable but stfu
	for q in range(0, values.size() + 1):
		if q < values.size() and values[q] == old:
			pairCount += 1
		else:
			#pretty slick eh? 0 = 0, 1 = 2, 2 = 6, 3 = 12
			score += (pairCount * pairCount) + pairCount
			#don't run this line an extra time tho
			if q < values.size():
				old = values[q]
			pairCount = 0
	
	return score
static func countFifteens(hand: Array, cut: Array, _crib: bool) -> int:
	var values = []
	for q in range(hand.size()):
		values.append(hand[q][0])
	values.append(cut[0])
	values.sort()
	values.reverse()
	var recurseFifteen = func fifteenRecurse(arr: Array, total: int, thisFunction: Callable) -> int:
		if arr.size() == 0: return 0
		var firstElem = arr[0]
		if firstElem > 10: firstElem = 10
		var newTotal = total + firstElem
		if newTotal == 15: return 1
		if newTotal > 15: return 0
		var ours = arr.duplicate()
		var ret: int = 0
		var newArray = ours.duplicate()
		for q in range(ours.size()):
			newArray.remove_at(0)
			ret += thisFunction.call(newArray, newTotal, thisFunction)
		ours.remove_at(0)
		return ret + thisFunction.call(ours, 0, thisFunction)
	return recurseFifteen.call(values, 0, recurseFifteen) * 2
	
static func countRuns(hand: Array, cut: Array, _crib: bool) -> int:
	var score: int = 0
	
	var values = []
	for q in range(hand.size()):
		values.append(hand[q][0])
	values.append(cut[0])
	values.sort()
	
	var runLength = 1
	var runDoubles = []
	var lastItem = values[0]
	for q in range(1, values.size()):
		if values[q] == lastItem:
			runDoubles.append(lastItem)
		elif values[q] == lastItem + 1:
			runLength += 1
		else:
			runLength = 1
			runDoubles = []
		lastItem = values[q]
	if runLength >= 3:
		if runDoubles.size() == 2:
			#if triple run
			if runDoubles[0] == runDoubles[1]:
				score = runLength * 3
			else:
				score = runLength * 4
		else:
			score = runLength * (runDoubles.size() + 1)
	
	return score

#hand must be an array of cards (arrays)
#cut is a card, an array of 2 numbers
static func countHand(hand: Array, cut: Array, crib: bool) -> int:
	assert(hand.size() == 4)
	var score: int = 0
	
	score += countFlush(hand, cut, crib)
	score += countNobs(hand, cut, crib)
	score += countPairs(hand, cut, crib)
	score += countFifteens(hand, cut, crib)
	score += countRuns(hand, cut, crib)
	
	
	return score
