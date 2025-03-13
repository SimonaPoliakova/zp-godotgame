extends CharacterBody2D

var bubble = preload("res://scenes/game_objects/bubble.tscn")

var speed = 160
var gravity = 20
var jump = -530

var bubble_speed = 270

var starting_position: Vector2 
 
@onready var jump_sound = $JumpSound   

func _ready():
	starting_position = global_position
	$AnimatedSprite2D.play("default")  

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = speed
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		$AnimatedSprite2D.play("run")  
		$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = 0
		$AnimatedSprite2D.play("default")  

	if Input.is_action_just_pressed("jump") and is_on_floor():
		if jump_sound:
			jump_sound.play()
		velocity.y = jump
		$AnimatedSprite2D.play("jump") 
	
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 0 and $AnimatedSprite2D.animation != "jump":  
			$AnimatedSprite2D.play("jump")

	if Input.is_action_just_pressed("shoot"):  
		shoot() 

	move_and_slide()

func shoot():  
	var bubble_ins = bubble.instantiate()  

	if bubble_ins == null:
		print("Error: Could not instantiate bubble!")
		return  

	var offset = Vector2(20, 0)  

	if $AnimatedSprite2D.flip_h:
		bubble_ins.global_position = global_position - offset 
		bubble_ins.speed = -bubble_speed 
	else:
		bubble_ins.global_position = global_position + offset  
		bubble_ins.speed = bubble_speed  

	get_parent().add_child(bubble_ins)  


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite2D.animation == "shoot":  
		$AnimatedSprite2D.play("default")  

func _on_enemy_checker_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"): 
		print("Player hit an enemy!")
		GameManager.decrease_health(1)
		global_position = starting_position

		
