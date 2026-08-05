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

func update_look():
	entity.look_at(entity.get_global_mouse_position())

func update_attack():
	if Input.is_action_just_pressed("attack"):
		entity.weapon_component.attack()
