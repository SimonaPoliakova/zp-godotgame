extends Node

var score: int = 0
var level: int = 1
var player_health: int = 3

@onready var game_ui = preload("res://scenes/GameUI.tscn").instantiate()

func _ready():
	get_tree().current_scene.add_child(game_ui)
	update_ui()
	get_tree().connect("scene_changed", Callable(self, "_on_scene_changed"))

func _on_scene_changed(new_scene):
	new_scene.add_child(game_ui)

func update_ui():
	if game_ui:
		var score_label = game_ui.get_node("ScoreLabel")
		if score_label:
			score_label.text = str(score)  # Update score text

func add_score(amount: int):
	score += amount
	update_ui()  # Update the UI with new score
