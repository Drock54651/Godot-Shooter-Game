extends CharacterBody2D
@export var speed: int = 200
var player_noticed: bool = false
var is_vulnerable: bool = true
@export var health: int = 50
var explosion_radius: int = 300
var speed_multiplier: int = 1
var has_exploded: bool = false

func _ready() -> void:
	$Explosion.hide()
	$DroneImage.show()

func _process(delta: float) -> void:
	if player_noticed:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("Explosions")
			has_exploded = true
			
	if has_exploded:
		var targets = get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
		for target in targets:
			if "hit" in target and target.global_position.distance_to(position) <= explosion_radius:
				target.hit()
	
	
func hit():
	if is_vulnerable:
		$DroneImage.material.set_shader_parameter("progress", 0.6)
		is_vulnerable = false
		health -= 10
		$HitTimer.start()
		
	if health <= 0:
		$AnimationPlayer.play("Explosions")
		has_exploded = true

func stop_movement():
	speed_multiplier = 0


func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_noticed = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "speed", speed*5, 6)
	

func _on_hit_timer_timeout() -> void:
	is_vulnerable = true
	$DroneImage.material.set_shader_parameter("progress", 0)
