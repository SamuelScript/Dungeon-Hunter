class_name Entity extends CharacterBody2D

@onready var health: HealthComponent = $Components/HealthComponent
@onready var movement: MovementComponent = $Components/MovementComponent
@onready var brain := $Brain/EntityBrain
@onready var weapon_component: WeaponComponent = $Components/WeaponComponent
@onready var weapon_socket: Marker2D = $WeaponSocket
var alive := true

func _ready() -> void:
	health.initialize(self)
	movement.initialize(self)
	weapon_component.initialize(self)
	brain.initialize(self)
	health.died.connect(_on_died)

func receive_damage(amount: int):
	health.damage(amount)
	print(
		name,
		" HP: ",
		health.current_health,
		"/",
		health.max_health
	)

func _on_died():
	alive = false
