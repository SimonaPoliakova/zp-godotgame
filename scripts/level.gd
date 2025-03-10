extends Node

func _ready():
	# No need to add GameUI here, GameManager is handling it
	# Just call check_level_completion to monitor the level state
	GameManager.check_level_completion()
	


func _on_main_menu_button_pressed() -> void:
	pass # Replace with function body.
