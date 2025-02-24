extends Area2D

var speed: float = 130

func _physics_process(delta):
	position.x += speed * delta  

func _on_bubble_body_entered(body):
	if body.is_in_group("enemy"): 
		body.queue_free()  
		queue_free()  
	elif body.is_in_group("walls"):  
		queue_free()  

func _on_Timer_timeout():
	queue_free() 
