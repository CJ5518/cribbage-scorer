extends Object

class_name CribbageThinker


#Returns an array containing every possible hand after discarding
#and statistics about the possible cut cards for each choice
static func getFullThoughtsOn6CardHand(hand: Array):
	var ret = []
	#create a copy for editing
	var tmp = hand.duplicate_deep()
	var startAt = 0
	#the two loops basically just remove two cards from the deck, and then on subsequent
	#iterations have two different cards removed
	for q in range(0, hand.size()):
		tmp.pop_at(q)
		var tmp2 = tmp.duplicate_deep()
		for i in range(startAt, hand.size() - 1):
			tmp2.pop_at(i)
			var cutValBuckets = _getDiscardChoiceThoughts(hand, tmp2)
			#calculate some more stats
			var minScore: int = 29
			var maxScore: int = 0
			var average: float = 0 
			for j in range(cutValBuckets.size()):
				var cutValBucket = cutValBuckets[j]
				minScore = min(cutValBucket.handScore, minScore)
				maxScore = max(cutValBucket.handScore, maxScore)
				average += cutValBucket.probability * cutValBucket.handScore
			ret.append({"handChoice": tmp2.duplicate_deep(), "thoughts": cutValBuckets, "min": minScore, "max": maxScore, "average": average})
			tmp2 = tmp.duplicate_deep()
		tmp = hand.duplicate_deep()
		startAt += 1
	return ret


static func _countOccurencesOfValInHand(hand: Array, val: int) -> int:
	var ret = 0
	for q in range(hand.size()):
		var card = hand[q]
		if card[0] == val:
			ret += 1
	return ret

static func _getDiscardChoiceThoughts(originalHand: Array, handChoice: Array):
	var results = []
	var resultsKey = {}
	var fourKind = _countOccurencesOfValInHand(originalHand, handChoice[0][0]) == 4
	for q in range(1, 14):
		if fourKind and q == handChoice[0][0]:
			pass
		else:
			var handScore = Cribbage.countHand(handChoice, [q,0], false)
			var leftInDeck = 4 - _countOccurencesOfValInHand(originalHand, q)
			var probability = leftInDeck / 46.0
			
			if resultsKey.has(handScore):
				results[resultsKey[handScore]].cutVals.append(q)
				results[resultsKey[handScore]].probability += probability
			else:
				resultsKey[handScore] = results.size()
				results.append({"probability": probability, "handScore": handScore, "cutVals": [q]})
	#Sort descending, makes the visualization gooder-er
	results.sort_custom(func(a,b): return a.handScore > b.handScore)
	return results
