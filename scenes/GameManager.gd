extends Node

var score: int = 0
var level: int = 1
var player_health: int = 3

@onready var game_ui = preload("res://scenes/GameUI.tscn").instantiate()

func _ready():
	call_deferred("add_game_ui") 
	update_ui()

func add_game_ui():
	get_tree().current_scene.add_child(game_ui)

func update_ui():
	if game_ui:
		var score_label = game_ui.get_node("ScoreLabel")
		var health_label = game_ui.get_node("HealthLabel")

		if score_label:
			score_label.text = str(score)
		if health_label:
			health_label.text = str(player_health)

		if player_health <= 0:
			var game_over_panel = get_tree().current_scene.find_child("GameOverPanel", true, false)
			if game_over_panel:
				game_over_panel.show_panel()

func decrease_health(amount: int):
	player_health -= amount
	update_ui()
