extends RigidBody2D

const speed: int = 1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func explode():
	$AnimationPlayer.play(("Explosion_Animation"))
	
	
