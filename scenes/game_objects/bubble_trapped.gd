extends CharacterBody2D

@export var float_speed: float = 50.0
@export var bobbing_amount: float = 5.0
@export var bobbing_speed: float = 2.0

var bubble_stop_point: Node2D = null
var has_stopped: bool = false
var stop_position: Vector2
var bobbing_offset: float = 0.0

func _ready():
	bubble_stop_point = get_tree().get_first_node_in_group("bubble_stop")

	bobbing_offset = randf_range(0, TAU) 

func _physics_process(delta):
	if bubble_stop_point and global_position.y > bubble_stop_point.global_position.y:
		velocity.y = -float_speed
		move_and_slide()
	else:
		if not has_stopped:
			has_stopped = true
			stop_position = position 

func _process(delta):
	if has_stopped:
		var bobbing_y = sin(Time.get_ticks_msec() / 1000.0 * bobbing_speed + bobbing_offset) * bobbing_amount
		position.y = stop_position.y + bobbing_y 
