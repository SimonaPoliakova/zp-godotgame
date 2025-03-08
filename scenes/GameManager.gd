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
		var level_label = game_ui.get_node("LevelLabel")
		var score_label = game_ui.get_node("ScoreLabel")
		var health_label = game_ui.get_node("HealthLabel")

		if level_label: level_label.text = "0" + str(level)
		if score_label: score_label.text = "" + str(score)
		if health_label: health_label.text = "" + str(player_health)

func add_score(amount: int):
	score += amount
	update_ui()

func set_health(health: int):
	player_health = health
	update_ui()

func show_game_over():
	var game_over_panel = game_ui.get_node("GameOverPanel")
	if game_over_panel:
		game_over_panel.visible = true
		get_tree().paused = true  

func restart_game():
	get_tree().paused = false
	score = 0
	level = 1
	player_health = 100
	update_ui()
	get_tree().change_scene_to_file("res://Level1.tscn")  
