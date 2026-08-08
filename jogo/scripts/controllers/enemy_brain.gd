class_name EnemyBrain extends Node

@export var stop_distance := 20.0
@export var target: Entity
@export var attack_damage: int = 10

var entity: Entity

func initialize(owner: Entity):
	entity = owner

func update():
	if target == null:
		entity.movement.direction = Vector2.ZERO
		return
	if not target.alive:
		entity.movement.direction = Vector2.ZERO
		return
	var distance = entity.global_position.distance_to(target.global_position)
	if distance <= stop_distance:
		entity.movement.direction = Vector2.ZERO
	else:
		entity.movement.direction = entity.global_position.direction_to(target.global_position)
