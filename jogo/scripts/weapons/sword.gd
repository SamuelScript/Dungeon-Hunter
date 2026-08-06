class_name Sword extends Weapon

@onready var hitbox: Area2D = $HitBoxs
@onready var collision: CollisionShape2D = $HitBoxs/CollisionShape2D
@onready var timer: Timer = $Timer
var attacking := false
var default_rotation := 0.0

func _ready() -> void:
	default_rotation = rotation

func attack():
	if attacking:
		return
	collision.disabled = false
	attacking = true
	rotation = deg_to_rad(45)
	timer.start()

func _on_timer_timeout():
	rotation = 0
	attacking = false
	collision.disabled = true
	rotation = default_rotation

func _on_hit_boxs_body_entered(body):
	if body is Entity and body != entity:
		body.receive_damage(damage)
