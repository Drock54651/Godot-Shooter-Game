extends CharacterBody2D

@export var max_speed: int = 500
var speed: int = max_speed
var can_laser: bool = true
var can_grenade: bool = true


signal laser_signal(pos, direction)
signal grenade_signal(pos, direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Input
	var direction = Input.get_vector("left", "right", 'up', 'down') 
	
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	# Rotate Player: look towards mouse pointer
	look_at(get_global_mouse_position())
	
	
	
	# Laser shooting
	if Input.is_action_just_pressed('primary action') and can_laser and Globals.laser_amount > 0:
		can_laser = false
		Globals.laser_amount -= 1
		$LaserTimer.start()
		
		# Randomly select a marker2D for the laser start
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		var player_direction = (get_global_mouse_position() - position).normalized()
		
		laser_signal.emit(selected_laser.global_position, player_direction)
		
		# Emit particles
		$LaserParticles.emitting = true
		
	if Input.is_action_just_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		can_grenade = false
		Globals.grenade_amount -= 1
		$GrenadeTimer.start()
		
		var grenade_markers = $GrenadeStartPositions.get_children()
		var selected_grenade = grenade_markers[randi() % grenade_markers.size()]
		var player_direction = (get_global_mouse_position() - position).normalized()
		
		grenade_signal.emit(selected_grenade.global_position, player_direction)

func _on_laser_timer_timeout() -> void:
	can_laser = true

func _on_grenade_timer_timeout() -> void:
	can_grenade = true
	
