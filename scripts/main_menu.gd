extends Control

@onready var start_button = $StartButton
@onready var exit_button = $ExitButton

func _ready(): 
	print("Main Menu Loaded. Current Level (after reset):", GameData.level)
	get_tree().paused = false
	
func _on_start_button_pressed():
	print("Restarting the game...")
	GameData.score = 0
	GameData.player_health = 3
	GameData.level = 1
	get_tree().change_scene_to_file("res://scenes/levels/starting_screen.tscn")


func _on_exit_button_pressed():
	print("Exiting the game...")
	get_tree().quit()
