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
	
static func countPairs(hand: Array, cut: Array, _crib: bool) -> int:
	var score: int = 0
	
	var values = []
	for q in range(hand):
		values.append(hand[q][0])
	values.append(cut[0])
	values.sort()
	
	#pairs
	var old = -1
	var pairCount = 0
	#run an extra time because we need to run the else condition again at the end
	#I suppose a different type of loop could be applicable but stfu
	for q in range(0, values.size() + 1):
		if values.size() < q and values[q] == old:
			pairCount += 1
		else:
			#pretty slick eh? 0 = 0, 1 = 2, 2 = 6, 3 = 12
			score += (pairCount * pairCount) + pairCount
			old = values[q]
			pairCount = 0
	
	return score
static func countFifteens(hand: Array, cut: Array, crib: bool) -> int:
	return 0

#hand must be an array of cards (arrays)
#cut is a card, an array of 2 numbers
static func countHand(hand: Array, cut: Array, crib: bool) -> int:
	assert(hand.size() == 5)
	var score: int = 0
	
	score += countFlush(hand, cut, crib)
	score += countNobs(hand, cut, crib)
	score += countPairs(hand, cut, crib)
	score += countFifteens(hand, cut, crib)
	
	
	return score
