extends CharacterBody2D
const speed: int = 200
func _process(_delta: float) -> void:
	# Direction
	var direction = Vector2(1,0)
	velocity = direction * speed
	move_and_slide()
