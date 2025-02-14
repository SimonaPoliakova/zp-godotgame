extends CharacterBody2D

@export var speed: float = 80.0  # Walking speed
@export var gravity: float = 500.0  # Gravity force
@export var jump_force: float = -360.0  # Jump force (Negative because Y is inverted in Godot)
@export var chase_distance: float = 2000.0  # Maximum distance at which the enemy will start chasing the player
@export var proximity_distance: float = 500.0  # Distance to check for the player being "next to" the enemy
@export var random_move_interval: float = 2.0  # Time before random movement direction changes
@export var highest_floor_y: float = 100.0  # Y position of the highest floor (adjust accordingly)

var player: Node2D = null  # Reference to player
var random_direction: Vector2 = Vector2.ZERO  # Direction to move randomly
var random_move_timer: float = 0  # Timer to change random direction

func _ready():
	player = get_tree().get_first_node_in_group("Player")  # Find the player node
	if player:
		random_direction = Vector2(randf_range(-1, 1), 0).normalized()

	self.collision_layer = 2  # Enemy layer (Layer 2)
	self.collision_mask = 1  # Mask to avoid collisions with other enemies (Mask 1)

func _process(delta):
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		
		if distance_to_player < chase_distance and abs(player.global_position.x - global_position.x) <= proximity_distance and player.global_position.y < global_position.y:
			_chase_player(delta)
		else:
			_random_movement(delta)

func _random_movement(delta):
	random_move_timer += delta
	if random_move_timer >= random_move_interval:
		random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		random_move_timer = 0

	velocity.x = random_direction.x * speed
	velocity.y += gravity * delta
	move_and_slide()

func _chase_player(delta):
	var direction_to_player = (player.global_position - global_position).normalized()
	velocity.x = direction_to_player.x * speed

	# Prevent jumping if already on the highest floor
	if global_position.y > highest_floor_y and player.global_position.y < global_position.y - 10 and is_on_floor():
		velocity.y = jump_force

	velocity.y += gravity * delta
	move_and_slide()
