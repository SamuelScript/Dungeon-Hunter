class_name GameManager extends Node

signal enemies_killed_changed(current: int)
signal victory()

@export var target_kills: int = 10

var enemies_killed := 0

func _ready() -> void:
	add_to_group("game_manager")

func enemy_killed():
	enemies_killed += 1
	enemies_killed_changed.emit(enemies_killed)
	if enemies_killed >= target_kills:
		victory.emit()
