class_name WeaponComponent extends Node

var entity: Player
var weapon: Weapon = null

func initialize(owner: Entity):
	entity = owner

func equip(new_weapon: Weapon):
	if weapon != null:
		weapon.queue_free()
	weapon = new_weapon
	entity.weapon_socket.add_child(weapon)
	weapon.position = Vector2.ZERO
	weapon.initialize(entity)
	weapon.on_equip()

func unequip():
	weapon = null

func has_weapon() -> bool:
	return weapon != null

func attack():
	if weapon == null:
		return
	weapon.attack()
