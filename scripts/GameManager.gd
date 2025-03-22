extends Node

var is_loading_next_level = false

@onready var game_ui_scene = preload("res://scenes/GameUI.tscn")

func _ready():
	update_ui() 
	check_level_completion()

func _process(delta):
	check_level_completion()  

func update_ui():
	var game_ui = get_tree().current_scene.get_node_or_null("GameUI")
	if game_ui:
		var score_label = game_ui.get_node_or_null("ScoreLabel")
		var health_label = game_ui.get_node_or_null("HealthLabel")
		var level_label = game_ui.get_node_or_null("LevelLabel") 

		if score_label:
			score_label.text = str(GameData.score)
		if health_label:
			health_label.text = str(GameData.player_health)
		if level_label:
			level_label.text = str(GameData.level).pad_zeros(2) 

	if GameData.player_health <= 0:
		var canvas_layer = get_tree().current_scene.get_node_or_null("CanvasLayer")
		if canvas_layer:
			var game_over_panel = canvas_layer.get_node_or_null("GameOverPanel")
			if game_over_panel:
				game_over_panel.show_panel()


func decrease_health(amount: int):
	GameData.player_health -= amount
	update_ui()

func add_score(amount: int):
	GameData.score += amount
	update_ui()

func check_level_completion():
	if get_tree().current_scene == null:
		return

	var current_scene_name = get_tree().current_scene.name

	if current_scene_name == "MainMenu" or current_scene_name == "StartingScreen":
		return

	var no_enemies_left = get_tree().get_nodes_in_group("enemy").is_empty()
	var no_bonuses_left = get_tree().get_nodes_in_group("bonus").is_empty()
	var no_trapped_enemies_left = get_tree().get_nodes_in_group("trapped_enemy").is_empty()

	if no_enemies_left and no_bonuses_left and no_trapped_enemies_left and not is_loading_next_level:
		print("All conditions met, loading next level.")
		is_loading_next_level = true
		load_next_level()


func load_next_level():
	var next_scene_name = "res://scenes/levels/level" + str(GameData.level + 1) + ".tscn"

	if ResourceLoader.exists(next_scene_name):
		GameData.level += 1
		GameData.player_health = 3 
		is_loading_next_level = false

		get_tree().call_deferred("change_scene_to_file", next_scene_name)

		await get_tree().process_frame 
		update_ui() 

	else:
		show_victory_panel()


func show_victory_panel():
	is_loading_next_level = false 
	GameData.score = 0
	GameData.player_health = 3
	GameData.level = 1 
	
	var canvas_layer = get_tree().current_scene.get_node_or_null("CanvasLayer")
	if canvas_layer:
		var victory_panel = canvas_layer.get_node_or_null("VictoryPanel")
		if victory_panel:
			victory_panel.show_panel()


func finish_game():
	print("Game Over")

	GameData.score = 0
	GameData.player_health = 3  
	GameData.level = 1  

	var canvas_layer = get_tree().current_scene.get_node_or_null("CanvasLayer")
	if canvas_layer:
		var game_over_panel = canvas_layer.get_node_or_null("GameOverPanel")
		if game_over_panel:
			game_over_panel.show_panel()
