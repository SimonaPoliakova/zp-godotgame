extends Control

@onready var main_menu_button = $MainMenuButton
@onready var confirm_sound = $ConfirmSound  

func _ready():
	visible = false  

func show_panel():
	visible = true
	get_tree().paused = true 

func hide_panel():
	visible = false
	get_tree().paused = false  

func _on_main_menu_button_pressed():
	if confirm_sound:
		confirm_sound.play()
	await get_tree().create_timer(0.3).timeout  
	AudioManager.stop_music()
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
