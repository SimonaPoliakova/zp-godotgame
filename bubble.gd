extends Area2D

var speed: float = 100  

func _physics_process(delta):
	position.x += speed * delta  

func _on_bubble_body_entered(body):
	get_parent().call("check_win")
	body.queue_free()
	queue_free()

func _on_Timer_timeout():
	queue_free()
