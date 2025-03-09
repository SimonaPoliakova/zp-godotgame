extends Node

var is_loading_next_level = false

@onready var game_ui_scene = preload("res://scenes/GameUI.tscn")

func _ready():
	update_ui() 
	check_level_completion()

func _process(delta):
	check_level_completion()  # Keep checking if the level is complete

func update_ui():
	# Get the GameUI node and update score and health labels
	var game_ui = get_tree().current_scene.get_node_or_null("GameUI")
	if game_ui:
		var score_label = game_ui.get_node_or_null("ScoreLabel")
		var health_label = game_ui.get_node_or_null("HealthLabel")

		if score_label:
			score_label.text = str(GameData.score)
		if health_label:
			health_label.text = str(GameData.player_health)

	# Show GameOverPanel if player health is 0
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
	var no_enemies_left = get_tree().get_nodes_in_group("enemy").is_empty()
	var no_bonuses_left = get_tree().get_nodes_in_group("bonus").is_empty()
	var no_trapped_enemies_left = get_tree().get_nodes_in_group("trapped_enemy").is_empty()

	# If no enemies, bonuses, or trapped enemies left, start loading the next level
	if no_enemies_left and no_bonuses_left and no_trapped_enemies_left and not is_loading_next_level:
		is_loading_next_level = true
		load_next_level()

func load_next_level():
	var next_scene_name = "res://scenes/levels/level" + str(GameData.level + 1) + ".tscn"

	if ResourceLoader.exists(next_scene_name):
		GameData.level += 1
		GameData.player_health = 3 
		is_loading_next_level = false

		# Load the next level and ensure UI is updated once the scene is loaded
		get_tree().change_scene_to_file(next_scene_name)

		# Wait a short time for the new scene to load, then update the UI
		await get_tree().process_frame  # Wait 1 frame for scene to load
		update_ui()  # Update UI for the new level
	else:
		finish_game()

func finish_game():
	print("Game Over")
	# Reset GameData to start fresh after game over
	GameData.score = 0
	GameData.player_health = 3  # Reset to starting health (or any default value)
	GameData.level = 1  # Reset to the first level (or any starting level)

	# Now, show the GameOver screen or return to main menu
	var canvas_layer = get_tree().current_scene.get_node_or_null("CanvasLayer")
	if canvas_layer:
		var game_over_panel = canvas_layer.get_node_or_null("GameOverPanel")
		if game_over_panel:
			game_over_panel.show_panel()

	# Optionally, add a delay before showing the GameOver panel (to allow final game state to settle)
	# You could use a Timer or delay to add a slight pause before showing the panel if necessary
