extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -780.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var last_direction = 1  # 1 = right, -1 = left

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle movement
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		last_direction = direction  # Save last movement direction
	else:
		velocity.x = move_toward(velocity.x, 0, 30)

	move_and_slide()

	# Flip the sprite based on last direction
	sprite_2d.flip_h = last_direction < 0  

	# ANIMATION LOGIC
	if not is_on_floor():
		sprite_2d.animation = "jumping"
	elif abs(velocity.x) > 1:
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"  # Use the same idle animation, just flipped

	# Play the selected animation
	sprite_2d.play()
