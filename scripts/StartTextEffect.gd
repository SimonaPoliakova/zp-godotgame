extends Control

@onready var text_label = $CanvasLayer/TextLabel  
@onready var prompt_label = $CanvasLayer/PromptLabel  

var full_text = """NOW IT IS THE BEGINNING OF A FANTASTIC STORY!
LET'S MAKE A JOURNEY TO THE CAVE OF MONSTERS!
GOOD LUCK!
"""
var type_speed = 0.05 
var is_typing = true  

func _ready():
	text_label.text = ""  
	prompt_label.visible = false  
	_start_typing()
	print("Current scene name:", get_tree().current_scene.name)
	


func _start_typing():
	var index = 0
	while index < full_text.length():
		text_label.text += full_text[index]
		index += 1
		await get_tree().create_timer(type_speed).timeout
	is_typing = false
	prompt_label.visible = true 

func _input(event):
	if !is_typing and event.is_pressed():
		_start_game()

func _start_game():

	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")
