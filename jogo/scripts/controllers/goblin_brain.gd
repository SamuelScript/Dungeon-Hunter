class_name GoblinBrain extends Node

@export var preferred_distance := 140.0
@export var minimum_distance := 80.0

var entity: Entity
var target: Entity

func initialize(owner: Entity):
	entity = owner

func set_target(new_target: Entity) -> void:
	target = new_target

func get_direction(owner_position: Vector2) -> Vector2:
	if target == null:
		return Vector2.ZERO

	var distance := owner_position.distance_to(target.global_position)
	var direction := owner_position.direction_to(target.global_position)

	if distance < minimum_distance:
		return -direction

	if distance > preferred_distance:
		return direction

	return Vector2.ZERO
