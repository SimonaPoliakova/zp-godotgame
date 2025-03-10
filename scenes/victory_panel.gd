extends Control

@onready var main_menu_button = $MainMenuButton

func _ready():
	visible = false  

func show_panel():
	visible = true
	get_tree().paused = true 

func hide_panel():
	visible = false
	get_tree().paused = false  

func _on_main_menu_button_pressed():
	# Reset GameData when returning to the main menu
	GameData.score = 0
	GameData.player_health = 3
	GameData.level = 1  # Make sure the level is reset to 1
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
