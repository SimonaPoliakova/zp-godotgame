extends Area2D

@export var teleport_target: Node2D 

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.is_in_group("enemy"):
		body.global_position = teleport_target.global_position + Vector2(0, 10)
