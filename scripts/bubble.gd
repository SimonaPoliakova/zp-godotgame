extends Area2D

@export var speed: float = 130.0
@export var max_distance: float = 250.0 
@export var trapped_bubble_scene: PackedScene 

var start_position: Vector2
var move_direction: float = 1.0
var has_captured_enemy: bool = false

@onready var bubbleblow_sound = $BubbleBlow

func _ready():
	start_position = global_position
	if bubbleblow_sound:
		bubbleblow_sound.play()


func _physics_process(_delta):
	if has_captured_enemy:
		return
	
	global_position.x += move_direction * speed * _delta
	
	if global_position.distance_to(start_position) >= max_distance:
		queue_free()

func set_direction(direction: float):
	move_direction = direction

func _on_bubble_body_entered(body):
	if body.is_in_group("enemy") and not has_captured_enemy:
		call_deferred("capture_enemy", body)  
	elif body.is_in_group("walls"):		queue_free()


func capture_enemy(enemy):
	has_captured_enemy = true
	var enemy_position = enemy.global_position
	enemy.call_deferred("queue_free") 

	if trapped_bubble_scene:
		var trapped_bubble = trapped_bubble_scene.instantiate()
		get_parent().add_child(trapped_bubble)
		trapped_bubble.global_position = enemy_position

	call_deferred("queue_free") 


func _on_Timer_timeout():
	queue_free()
