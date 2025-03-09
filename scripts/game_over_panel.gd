extends Control

@onready var main_menu_button = $MainMenuButton
@onready var restart_button = $RestartButton

func _ready():
	visible = false  # Initially hidden

func show_panel():
	visible = true
	get_tree().paused = true  # Pause the game when the panel is visible

func hide_panel():
	visible = false
	get_tree().paused = false  # Unpause the game when the panel is hidden

# Main menu button action
func _on_main_menu_button_pressed():
	print("Main menu button clicked!")
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")

# Restart button action
func _on_restart_button_pressed():
	# Reset the GameData before restarting
	GameData.score = 0
	GameData.player_health = 3  # Reset to initial health
	GameData.level = 0  # Reset to first level (Important!)

	hide_panel()  # Hide the GameOver panel

	# Load level 1 after resetting the game data
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")    # Restart the first level
