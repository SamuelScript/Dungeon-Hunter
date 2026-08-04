class_name MovementComponent extends Node

@export var speed: float = 200.0

var entity: Entity
var direction: Vector2 = Vector2.ZERO

func initialize(owner: Entity):
	entity = owner

func get_velocity() -> Vector2:
	return direction.normalized() * speed
