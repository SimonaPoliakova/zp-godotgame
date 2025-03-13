extends Area2D

@export var bonus_value: int = 1000  
@onready var collected_sound = $CollectedSound

func _ready():
	add_to_group("bonus")

func _on_body_entered(body):
	if body.is_in_group("player"):
		GameManager.add_score(bonus_value)  
		if collected_sound:
			collected_sound.play()
		await get_tree().create_timer(0.15).timeout 
		queue_free()  
