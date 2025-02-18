extends CharacterBody2D

var speed = 60
var gravity = 20
var jump = -530

func _ready():
	$AnimatedSprite2D.play("run")
	velocity.x = speed 

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity

	var collision = move_and_slide()

	if is_on_wall():
		speed = -speed 
		velocity.x = speed  
		$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h  
	else:
		velocity.x = speed  


func _on_jump_timeout():
	if is_on_floor():
		# Randomize jump height within a range
		jump = randf_range(-300, -600)  # Randomize the jump height, can adjust the range
		velocity.y = jump  # Apply the random jump value
