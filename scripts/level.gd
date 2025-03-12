extends Node

func _ready():
	GameManager.check_level_completion()
	
func restart():
	get_tree().reload_current_scene()
	
