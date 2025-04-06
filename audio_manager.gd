extends Node

@onready var music = $Music

func _ready():
	music.stop() 

func play_music():
	var current_scene = get_tree().current_scene
	if current_scene and current_scene.name not in ["main_menu", "starting_screen"]:
		if not music.playing:
			music.play()

func stop_music():
	if music.playing:
		music.stop()
