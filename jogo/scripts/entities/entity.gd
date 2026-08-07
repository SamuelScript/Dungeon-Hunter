class_name Entity extends CharacterBody2D

@onready var health: HealthComponent = $Components/HealthComponent
@onready var movement: MovementComponent = $Components/MovementComponent
@onready var brain := $Brain/EntityBrain
@onready var weapon_component: WeaponComponent = $Components/WeaponComponent
@onready var weapon_socket: Marker2D = $WeaponSocket
@onready var invulnerability_timer: Timer = $InvulnerabilityTimer

var alive := true

func _ready() -> void:
	health.initialize(self)
	movement.initialize(self)
	weapon_component.initialize(self)
	brain.initialize(self)
	health.died.connect(_on_died)
	invulnerability_timer.timeout.connect(_on_invulnerability_timeout)

func receive_damage(amount: int):
	if self.name.to_lower() != "player":
		print(self.name, " - hp : ", health.current_health)
	if health.invulnerable:
		return
	health.damage(amount)
	health.invulnerable = true
	invulnerability_timer.start(health.invulnerability_time)
	modulate.a = 0.5

func _on_died():
	alive = false

func _on_invulnerability_timeout():
	health.invulnerable = false
	modulate.a = 1.0
