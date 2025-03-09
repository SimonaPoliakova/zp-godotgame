extends Area2D

@export var bonus_value: int = 1000  

func _on_body_entered(body):
	if body.is_in_group("player"):
		GameManager.add_score(bonus_value)  
		queue_free()  
