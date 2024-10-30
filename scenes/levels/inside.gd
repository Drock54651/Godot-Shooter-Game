extends LevelParent
@export var outside_level_scene: PackedScene

func _on_exit_gate_area_body_entered(_body: Node2D) -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	#get_tree().change_scene_to_file("res://scenes/levels/outside.tscn")
	get_tree().change_scene_to_packed.call_deferred(outside_level_scene)
