extends Control

@onready var main_menu_button = $MainMenuButton
@onready var restart_button = $RestartButton

func _ready():
	visible = false 

func show_panel():
	visible = true
	get_tree().paused = true  

func hide_panel():
	visible = false
	get_tree().paused = false  

func _on_main_menu_button_pressed():
	print("Main menu button clicked!")
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")

func _on_restart_button_pressed():
	GameData.score = 0
	GameData.player_health = 3  
	GameData.level = 1

	hide_panel()  


	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")    
