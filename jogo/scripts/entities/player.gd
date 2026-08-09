class_name Player extends Entity

const SWORD_SCENE = preload("res://scenes/weapons/Sword.tscn")
const SPEED = 300.0

@onready var damage_sound: AudioStreamPlayer = $DamageSound

func _ready() -> void:
	super()
	self.add_to_group("player")
	weapon_component.equip(SWORD_SCENE.instantiate())

func _physics_process(delta: float) -> void:
	if !alive:
		return
	brain.update_input()
	brain.update_look()
	brain.update_attack()
	velocity = movement.get_velocity()
	move_and_slide()

func receive_damage(amount: int):
	var previous_health = health.current_health
	super(amount)
	if health.current_health < previous_health:
		damage_sound.play()
