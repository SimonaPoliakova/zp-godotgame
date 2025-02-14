extends CharacterBody2D

@export var SPEED = 200.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@export var bubble_scene: PackedScene  # Reference to the Bubble scene

var last_direction = 1  # 1 = right, -1 = left

func _ready():
	# Make sure to initialize the velocity
	velocity = Vector2.ZERO  # This will be the built-in velocity property in CharacterBody2D

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -780.0  # Adjust jump force as needed
	
	# Handle movement
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		last_direction = direction  # Save last movement direction
	else:
		velocity.x = move_toward(velocity.x, 0, 30)

	# Move the player using the updated velocity (no arguments passed)
	move_and_slide()

	# Flip the sprite based on last direction
	sprite_2d.flip_h = last_direction < 0  

	# Animation logic
	if not is_on_floor():
		sprite_2d.animation = "jumping"  # Change this to match your jumping animation
	elif abs(velocity.x) > 1:
		sprite_2d.animation = "running"  # Running animation
	else:
		sprite_2d.animation = "default"  # Idle animation

	# Play the selected animation
	sprite_2d.play()

	# Handle shooting
	if Input.is_action_just_pressed("shoot"):
		shoot_bubble()

func shoot_bubble():
	if bubble_scene:
		var bubble = bubble_scene.instantiate() as CharacterBody2D
		get_parent().add_child(bubble)

		# Spawn bubble slightly in front of the player based on the direction
		var offset = Vector2(40 * sign(last_direction), 10)  # Moves in front & slightly above the player
		bubble.global_position = global_position + offset
		
		# Set the bubble's movement direction based on the last_direction
		if last_direction == 1:  # Facing right
			bubble.velocity = Vector2(SPEED, 0)  # Moving right
		else:  # Facing left
			bubble.velocity = Vector2(-SPEED, 0)  # Moving left
		
		# Debugging the velocity
		print("Bubble velocity: ", bubble.velocity)
	else:
		print("Bubble scene not assigned!")
