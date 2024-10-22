extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP
func _process(delta: float) -> void:
	position += speed * delta * direction


func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if "hit" in body:
		body.hit()
		
	queue_free()
