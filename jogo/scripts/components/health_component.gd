class_name HealthComponent extends Node

signal health_changed(current: int, maximum: int)
signal damaged(amount: int)
signal healed(amount: int)
signal died()

@export var max_health: int = 100
@export var invulnerability_time: float = 0.5

var invulnerable := false
var entity : Entity
var current_health: int

func initialize(owner : Entity) :
	entity = owner

func _ready() -> void:
	current_health = max_health

func damage(amount: int):
	if amount < 0:
		return
	current_health -= amount
	if current_health < 0:
		current_health = 0
	damaged.emit(amount)
	health_changed.emit(current_health,max_health)
	if current_health == 0:
		died.emit()

func heal(amount: int):
	if amount <= 0:
		return
	current_health += amount
	if current_health > max_health:
		current_health = max_health
	healed.emit(amount)
	health_changed.emit(current_health,max_health)

func restore():
	current_health= max_health
	health_changed.emit(current_health,max_health)

func is_dead() -> bool:
	return current_health <= 0
