class_name Entity extends CharacterBody2D

@onready var health: HealthComponent = $Components/HealthComponent

func _ready() -> void:
	health.initialize(self)
