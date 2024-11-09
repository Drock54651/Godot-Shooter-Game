extends RigidBody2D

const speed: int = 1000
var explosion_active: bool = false
var explosion_radius: int = 400

func explode():
	explosion_active = true
	$AnimationPlayer.play(("Explosion_Animation"))
	
	
func _process(_delta: float) -> void:
	if explosion_active:
		explosion_active = false
		var targets = get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
		for target in targets:
			if "hit" in target and target.global_position.distance_to(position) <= explosion_radius:
				target.hit()
		
