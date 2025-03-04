extends CharacterBody2D

@export var speed := 60.0
@export var gravity := 16.0
@export var jump_force_min := -420.0
@export var jump_force_max := -510.0
@export var detection_range := 150.0  # Adjusted for Godot's units
@export var jump_interval_min := 2.0  
@export var jump_interval_max := 5.0  

@onready var sprite = $AnimatedSprite2D
@onready var jump_timer = $JumpTimer
@onready var player = get_tree().get_first_node_in_group("player")

var facing_right := true

func _ready():
	add_to_group("enemy")
	sprite.play("run")
	velocity.x = speed if facing_right else -speed
	schedule_next_jump()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity

	if player and global_position.distance_to(player.global_position) < detection_range:
		chase_player()
	else:
		patrol()

	move_and_slide()

	if is_on_wall():
		flip()

func chase_player():
	if not player:
		return

	var direction = 1 if player.global_position.x > global_position.x else -1
	velocity.x = direction * speed

	if (direction > 0 and not facing_right) or (direction < 0 and facing_right):
		flip()

func patrol():
	velocity.x = speed if facing_right else -speed

func flip():
	facing_right = not facing_right
	sprite.flip_h = not sprite.flip_h
	velocity.x = -velocity.x

func jump():
	if is_on_floor():
		velocity.y = randf_range(jump_force_min, jump_force_max)
		schedule_next_jump()

func schedule_next_jump():
	jump_timer.start(randf_range(jump_interval_min, jump_interval_max))

func _on_JumpTimer_timeout():
	jump()
