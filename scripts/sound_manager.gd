extends Node


#right
func _on_game_scene_correct_answer(hand: Array, cutCard: Array, time: float, score: int) -> void:
	$CorrectSound.play()

#wrong
func _on_game_scene_wrong_answer(hand: Array, cutCard: Array, time: float, score: int) -> void:
	$WrongSound.play()
