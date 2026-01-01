extends Object

class_name Cards

enum SUIT {
	CLUB,
	SPADE,
	HEART,
	DIAMOND
}

#Takes a value 1-13 and returns A,2,3,4...,9,10,J,Q,K
static func valueToCharacters(value):
	if value >= 2 and value <= 10:
		return str(value)
	match value:
		1:
			return "A"
		11:
			return "J"
		12:
			return "Q"
		13:
			return "K"
	#If all else fails return E for error
	return "E"
