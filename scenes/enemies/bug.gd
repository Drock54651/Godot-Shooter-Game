extends CharacterBody2D

@export var speed: int = 300
@export var attack_cooldown: int = 1 # seconds
var player_in_notice_area: bool = false
var player_in_attack_area: bool = false
var can_attack = true
var vulnerable: bool = true
@export var health = 20

func hit():
	if vulnerable:
		vulnerable = false
		health -= 10
		$Timers/HitTimer.start()
		$AnimatedSprite2D.material.set_shader_parameter("progress", 0.6)
		$Particles/HitParticles.emitting = true
		
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		queue_free()
		

func _on_notice_area_2d_body_entered(_body: Node2D) -> void:
	$AnimatedSprite2D.play("WalkingAnimation")
	player_in_notice_area = true
	
func _on_notice_area_2d_body_exited(_body: Node2D) -> void:
	player_in_notice_area = false
	$AnimatedSprite2D.stop()


func _on_attack_area_2d_body_entered(_body: Node2D) -> void:
	player_in_attack_area = true

func _on_attack_area_2d_body_exited(_body: Node2D) -> void:
	player_in_attack_area = false
	$AnimatedSprite2D.play("WalkingAnimation")

func _on_attack_cooldown_timeout() -> void:
	can_attack = true
	
func _on_hit_timer_timeout() -> void:
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)

func _process(_delta: float) -> void:
	var direction: Vector2 = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	
	# Should not move if player is inside the attack area
	if player_in_notice_area and not player_in_attack_area:
		move_and_slide()
		look_at(Globals.player_pos)
		
	if player_in_attack_area and can_attack:
		$AnimatedSprite2D.play("AttackAnimation")


func _on_animated_sprite_2d_animation_finished() -> void:
	Globals.health -= 10
	can_attack = false
	$Timers/AttackCooldown.start(attack_cooldown)
	
