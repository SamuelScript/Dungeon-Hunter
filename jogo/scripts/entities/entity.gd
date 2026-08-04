class_name Entity extends CharacterBody2D

@onready var health: HealthComponent = $Components/HealthComponent
@onready var movement: MovementComponent = $Components/MovementComponent

func _ready() -> void:
	health.initialize(self)
	movement.initialize(self)
