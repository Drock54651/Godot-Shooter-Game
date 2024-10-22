extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(_body) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)


func _on_player_laser_signal(pos, direction) -> void:
	var laser: Area2D = laser_scene.instantiate()
	# Update laser position to laser markers
	laser.position = pos
	print('hello')
	laser.rotation_degrees = rad_to_deg (direction.angle()) + 90
	laser.direction = direction 
	$Projectiles.add_child(laser)
	print("test1")

func _on_player_grenade_signal(pos, direction) -> void:
	var grenade: RigidBody2D = grenade_scene.instantiate()
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)


func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1).set_trans(Tween.TRANS_EXPO)
	#tween.tween_property($Player, "modulate:a", 0, 2).from(0.5)
	
	
func _on_house_player_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 1)
