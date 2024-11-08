extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")


func _ready():
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("open", on_container_open)
		
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect("laser", _on_scout_laser)

func on_container_open(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)
	

func _on_player_laser_signal(pos, direction) -> void:
	create_laser(pos, direction)
	

func _on_player_grenade_signal(pos, direction) -> void:
	var grenade: RigidBody2D = grenade_scene.instantiate()
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	
func _on_scout_laser(pos, direction):
	create_laser(pos, direction)
	
func create_laser(pos, direction):
	var laser: Area2D = laser_scene.instantiate()
	# Update laser position to laser markers
	laser.position = pos
	laser.rotation_degrees = rad_to_deg (direction.angle()) + 90
	laser.direction = direction 
	$Projectiles.add_child(laser)
