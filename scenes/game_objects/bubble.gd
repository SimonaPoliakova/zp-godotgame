extends CharacterBody2D

@export var SPEED = 200  # Speed of the bubble

func _physics_process(_delta):
	# Use move_and_slide to move the bubble based on its velocity
	move_and_slide()  # The velocity is automatically applied here in Godot 4.x
