extends Entity

const SWORD_SCENE = preload("res://scenes/weapons/Sword.tscn")

const SPEED = 300.0

func _ready() -> void:
	super()
	weapon_component.equip(SWORD_SCENE.instantiate())

func _physics_process(delta: float) -> void:
	brain.update_input()
	brain.update_look()
	velocity = movement.get_velocity()
	move_and_slide()
