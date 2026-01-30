extends GutTest

func assertScoreIs(hand: Array, cut: Array, crib: bool, score: int):
	assert_eq(Cribbage.countHand(hand, cut, crib), score)


func test_flushCounts():
	var suit = Cards.SUIT.DIAMOND
	assertScoreIs([[2,suit],[4,suit],[6,suit],[8,suit]], [10,suit], false, 5)
	assertScoreIs([[2,suit],[4,suit],[6,suit],[8,suit]], [10,suit], true, 5)
	assertScoreIs([[2,suit],[4,suit],[6,suit],[8,suit]], [10,Cards.SUIT.SPADE], true, 0)
	assertScoreIs([[2,suit],[4,suit],[6,suit],[8,suit]], [10,Cards.SUIT.SPADE], false, 4)
	assertScoreIs([[2,Cards.SUIT.SPADE],[4,suit],[6,suit],[8,suit]], [10,suit], false, 0)
	assertScoreIs([[2,suit],[4,suit],[6,Cards.SUIT.SPADE],[8,suit]], [10,suit], false, 0)
	assertScoreIs([[2,suit],[4,suit],[6,suit],[8,Cards.SUIT.SPADE]], [10,suit], false, 0)
	
func test_nobsAndFlush():
	var suit = Cards.SUIT.DIAMOND
	assertScoreIs([[2,suit],[4,suit],[6,suit],[11,suit]], [10,suit], false, 6)
	assertScoreIs([[2,suit],[4,suit],[6,suit],[10,suit]], [11,suit], false, 5)
	assertScoreIs([[2,suit],[4,suit],[6,suit],[11,suit]], [10,suit], true, 6)
	assertScoreIs([[2,suit],[4,suit],[6,suit],[10,suit]], [11,suit], true, 5)
	
	assertScoreIs([[2,suit],[4,suit],[6,Cards.SUIT.SPADE],[11,suit]], [10,suit], false, 1)
	assertScoreIs([[2,suit],[4,suit],[6,Cards.SUIT.SPADE],[11,suit]], [10,suit], true, 1)
	
func test_pairs():
	var suit = Cards.SUIT.CLUB
	#technically these hands can't exist, but the pair checker doesn't care about suits anyway
	#just make one card a different suit so it doesn't count a flush
	assertScoreIs([[2,Cards.SUIT.DIAMOND],[2,suit],[6,suit],[8,suit]], [10,suit], false, 2)
	assertScoreIs([[2,Cards.SUIT.DIAMOND],[2,suit],[6,suit],[2,suit]], [10,suit], false, 6)
	assertScoreIs([[2,Cards.SUIT.DIAMOND],[2,suit],[2,suit],[8,suit]], [10,suit], false, 6)
	assertScoreIs([[2,Cards.SUIT.DIAMOND],[2,suit],[4,suit],[8,suit]], [2,suit], false, 6)
	assertScoreIs([[2,Cards.SUIT.DIAMOND],[2,suit],[4,suit],[4,suit]], [2,suit], false, 8)
	assertScoreIs([[2,Cards.SUIT.DIAMOND],[2,suit],[4,suit],[2,suit]], [2,suit], false, 12)
	
func test_runs():
	var suit = Cards.SUIT.CLUB
	assertScoreIs([[8,Cards.SUIT.DIAMOND],[9,suit],[10,suit],[1,suit]], [2,suit], false, 3)
	assertScoreIs([[8,suit],[9,suit],[10,suit],[11,Cards.SUIT.DIAMOND]], [2,suit], false, 4)
	assertScoreIs([[8,suit],[9,suit],[10,suit],[11,Cards.SUIT.DIAMOND]], [12,suit], false, 5)
	assertScoreIs([[8,Cards.SUIT.DIAMOND],[9,suit],[10,suit],[10,suit]], [2,suit], false, 8)
	assertScoreIs([[8,Cards.SUIT.DIAMOND],[9,suit],[10,suit],[10,suit]], [11,suit], false, 10)
	assertScoreIs([[8,Cards.SUIT.DIAMOND],[9,suit],[10,suit],[10,suit]], [10,suit], false, 15)
	assertScoreIs([[9,Cards.SUIT.DIAMOND],[9,suit],[10,suit],[10,suit]], [11,suit], false, 16)

func test_fifteens():
	var suit = Cards.SUIT.CLUB
	assertScoreIs([[2,Cards.SUIT.DIAMOND],[2,suit],[3,suit],[10,suit]], [10,suit], false, 12)
	assertScoreIs([[5,Cards.SUIT.DIAMOND],[5,suit],[5,suit],[5,suit]], [10,suit], false, 28)
	assertScoreIs([[5,Cards.SUIT.DIAMOND],[5,suit],[5,suit],[11,suit]], [5,suit], false, 29)
	assertScoreIs([[4,Cards.SUIT.DIAMOND],[4,suit],[4,suit],[7,suit]], [7,suit], false, 20)

#count some other hands
func test_counting():
	var suit = Cards.SUIT.HEART
	assertScoreIs([[4,suit],[5,suit],[3,suit],[6,suit]], [4,Cards.SUIT.SPADE], false, 18)
	assertScoreIs([[4,suit],[5,suit],[6,Cards.SUIT.SPADE],[6,suit]], [4,Cards.SUIT.SPADE], false, 24)
	assertScoreIs([[5, suit],[5,Cards.SUIT.CLUB],[5,suit],[5,suit]], [6,0], false, 20)
