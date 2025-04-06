extends Control

@onready var start_button = $StartButton
@onready var exit_button = $ExitButton
@onready var start_sound = $ConfirmSound
@onready var exit_sound = $ExitSound   

func _ready(): 
	get_tree().paused = false
	AudioManager.stop_music()

func _on_start_button_pressed():
	if start_sound:
		start_sound.play()
	
	GameData.score = 0
	GameData.player_health = 3
	GameData.level = 1
	
	await get_tree().create_timer(0.3).timeout  
	get_tree().change_scene_to_file("res://scenes/levels/starting_screen.tscn")

func _on_exit_button_pressed():
	print("Exiting the game...")

	if exit_sound:
		exit_sound.play()
	
	await get_tree().create_timer(0.3).timeout  
	get_tree().quit()
