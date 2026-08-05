class_name Entity extends CharacterBody2D

@onready var health: HealthComponent = $Components/HealthComponent
@onready var movement: MovementComponent = $Components/MovementComponent
@onready var brain : PlayerBrain = $Brain/PlayerBrain
@onready var weapon_component: WeaponComponent = $Components/WeaponComponent
@onready var weapon_socket: Marker2D = $WeaponSocket

func _ready() -> void:
	health.initialize(self)
	movement.initialize(self)
	weapon_component.initialize(self)
	brain.initialize(self)
