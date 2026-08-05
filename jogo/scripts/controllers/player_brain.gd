class_name PlayerBrain extends Node

var entity: Entity

func initialize(owner: Entity):
	entity = owner

func update_input():
	entity.movement.direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
