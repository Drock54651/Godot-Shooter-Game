extends CharacterBody2D
var player_nearby: bool = false
var can_laser: bool = true
var right_gun_use: bool = true
var health: int = 30
var vulnearble: bool = true
signal laser(pos, direction)

func _process(_delta: float) -> void:
	
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var marker_node = $LaserSpawnPositions.get_child(right_gun_use)
			right_gun_use = !right_gun_use
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timers/LaserTimer.start()
		
	
		

func hit():
	if vulnearble:
		health -= 10
		vulnearble = false
		$Timers/InvulnerableTime.start()
		$Sprite2D.material.set_shader_parameter("progress", 1)
	if health <= 0:
		queue_free()

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false



func _on_laser_timer_timeout() -> void:
	can_laser = true


func _on_invulnerable_time_timeout() -> void:
	vulnearble = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
