class_name Weapon extends Node2D

@export var damage: int = 10
@export var attack_cooldown: float = 0.5

var entity: Entity

func initialize(owner: Entity):
	entity = owner

func attack():
	pass

func on_equip():
	pass

func on_unequip():
	pass
