extends Area2D

@export var bonus_value: int = 1000  

func _ready():
	# Make sure that this object is added to the bonus group
	add_to_group("bonus")

func _on_body_entered(body):
	if body.is_in_group("player"):
		GameManager.add_score(bonus_value)  
		queue_free()  
