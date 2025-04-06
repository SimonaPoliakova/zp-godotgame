extends Node

func _ready():
	AudioManager.play_music()
	GameManager.check_level_completion()
	
func restart():
	get_tree().reload_current_scene()
	
