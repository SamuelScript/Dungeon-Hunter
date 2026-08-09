class_name Entity extends CharacterBody2D

@onready var health: HealthComponent = $Components/HealthComponent
@onready var movement: MovementComponent = $Components/MovementComponent
@onready var brain := $Brain/EntityBrain
@onready var weapon_component: WeaponComponent = $Components/WeaponComponent
@onready var weapon_socket: Marker2D = $WeaponSocket
@onready var invulnerability_timer: Timer = $InvulnerabilityTimer

var alive := true
var invulnerable := false

func _ready() -> void:
	health.initialize(self)
	movement.initialize(self)
	weapon_component.initialize(self)
	brain.initialize(self)
	health.died.connect(_on_died)
	invulnerability_timer.timeout.connect(_on_invulnerability_timeout)

func receive_damage(amount: int):
	if not alive:
		return
	if invulnerable:
		return
	health.damage(amount)
	flash_damage()
	invulnerable = true
	invulnerability_timer.start(0.5)
	modulate.a = 0.5

func _on_died():
	alive = false

func _on_invulnerability_timeout():
	invulnerable = false
	modulate = Color.WHITE

func flash_damage():
	modulate = Color(1.0, 0.4, 0.4,0.5)
	await get_tree().create_timer(0.1).timeout
	if alive:
		modulate = Color(1.0,1.0,1.0,0.5)
