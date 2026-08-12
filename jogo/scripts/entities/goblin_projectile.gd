class_name GoblinProjectile extends Area2D

@onready var attack_sound: AudioStreamPlayer = $AttackSound
@export var speed := 180.0
@export var damage := 10

var direction := Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func set_direction(new_direction: Vector2) -> void:
	attack_sound.play()
	direction = new_direction.normalized()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.receive_damage(damage)
		queue_free()
