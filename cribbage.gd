extends Object

class_name Cribbage





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
	if isFourCardFlush and not crib:
		score += 4
	return score
	
static func countNobs(hand: Array, cut: Array, _crib: bool) -> int:
	for q in range(0, hand.size()):
		if hand[q][0] == 11 and hand[q][1] == cut[1]:
			return 1
	return 0
	
static func countRuns(hand: Array, cut: Array, crib: bool) -> int:
	pass
static func countPairs(hand: Array, cut: Array, crib: bool) -> int:
	pass
static func countFifteens(hand: Array, cut: Array, crib: bool) -> int:
	pass

#hand must be an array of cards (arrays)
#cut is a card, an array of 2 numbers
static func countHand(hand: Array, cut: Array, crib: bool) -> int:
	assert(hand.size() == 5)
	var score: int = 0
	
	score += countFlush(hand, cut, crib)
	score += countNobs(hand, cut, crib)
	
	
	return score
