extends Area2D

@export var float_speed: float = 50.0
@export var bobbing_amount: float = 5.0
@export var bobbing_speed: float = 2.0
@export var bonuses: Array[PackedScene]  
@export var platform_group: String = "platform_spawn"  

var bubble_stop_point: Node2D = null
var has_stopped: bool = false
var stop_position: Vector2
var bobbing_offset: float = 0.0
var platforms: Array

func _ready():
	bubble_stop_point = get_tree().get_first_node_in_group("bubble_stop")
	platforms = get_tree().get_nodes_in_group(platform_group)
	bobbing_offset = randf_range(0, TAU)

func _physics_process(delta):
	if bubble_stop_point and global_position.y > bubble_stop_point.global_position.y:
		position.y -= float_speed * delta  
	else:
		if not has_stopped:
			has_stopped = true
			stop_position = position

func _process(delta):
	if has_stopped:
		var bobbing_y = sin(Time.get_ticks_msec() / 1000.0 * bobbing_speed + bobbing_offset) * bobbing_amount
		position.y = stop_position.y + bobbing_y  

func _on_BubbleTrapped_body_entered(body):
	if body.is_in_group("player"):
		release_bonus()
		queue_free()

func release_bonus():
	if bonuses.is_empty() or platforms.is_empty():
		return

	var selected_platform = platforms[randi() % platforms.size()]
	var random_x_offset = randf_range(-250.0, 250.0)
	var spawn_position = Vector2(
		selected_platform.global_position.x + random_x_offset,
		selected_platform.global_position.y
	)

	var random_bonus = bonuses[randi() % bonuses.size()]

	var bonus_instance = random_bonus.instantiate()
	if bonus_instance == null:
		return

	get_parent().call_deferred("add_child", bonus_instance)
	bonus_instance.global_position = spawn_position

	var animated_sprite2d = bonus_instance.get_node("AnimatedSprite2D")  
	if animated_sprite2d:
		animated_sprite2d.play("default")  
