extends CharacterBody2D

var speed = 60
var gravity = 16
var jump_force_min = -420
var jump_force_max = -510

var jump_interval_min = 2.0  # Minimum time before jumping
var jump_interval_max = 5.0  # Maximum time before jumping

func _ready():
	add_to_group("enemy")  
	$AnimatedSprite2D.play("run")
	velocity.x = speed 
	schedule_next_jump()  

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

func jump():
	if is_on_floor():
		var random_jump = randf_range(jump_force_max, jump_force_min)  
		velocity.y = random_jump  
		schedule_next_jump()

func schedule_next_jump():
	var random_time = randf_range(jump_interval_min, jump_interval_max)
	$JumpTimer.start(random_time)  

func _on_JumpTimer_timeout():
	jump()
