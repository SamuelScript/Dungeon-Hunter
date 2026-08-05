class_name WeaponComponent extends Node

var entity: Entity
var weapon: Weapon = null

func initialize(owner: Entity):
	entity = owner

func equip(new_weapon: Weapon):
	weapon = new_weapon

func unequip():
	weapon = null

func has_weapon() -> bool:
	return weapon != null
