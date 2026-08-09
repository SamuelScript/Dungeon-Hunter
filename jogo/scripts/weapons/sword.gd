class_name Sword extends Weapon

@onready var attack_sound: AudioStreamPlayer = $AttackSound
@onready var hitbox: Area2D = $HitBoxs
@onready var collision: CollisionShape2D = $HitBoxs/CollisionShape2D
@onready var timer: Timer = $Timer

var attacking := false
var default_rotation := 0.0
var hit_targets: Array[Entity] = []

func _ready() -> void:
	default_rotation = rotation

func attack():
	if attacking:
		return
	attack_sound.play()
	attacking = true
	hit_targets.clear()
	collision.disabled = false
	var bodies = hitbox.get_overlapping_bodies()
	for body in bodies:
		_on_hit_boxs_body_entered(body)
	
	rotation = deg_to_rad(45)
	timer.start()

func _on_timer_timeout():
	rotation = 0
	attacking = false
	collision.disabled = true
	rotation = default_rotation

func _on_hit_boxs_body_entered(body):
	if body == entity:
		return
	if not body is Entity:
		return
	if body in hit_targets:
		return
	hit_targets.append(body)
	body.receive_damage(damage)
