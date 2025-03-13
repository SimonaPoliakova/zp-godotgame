extends Node

@onready var music = $Music


func _ready():
	if music:
		music.play()
	GameManager.check_level_completion()
	
func restart():
	get_tree().reload_current_scene()
	
