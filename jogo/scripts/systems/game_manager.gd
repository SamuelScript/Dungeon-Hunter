class_name GameManager extends Node

signal enemies_killed_changed(current: int,count_max:int)
signal victory()
signal game_over()

@export var target_kills: int = 5

var enemies_killed := 0
var game_finished := false

func _ready() -> void:
	add_to_group("game_manager")

func enemy_killed():
	enemies_killed += 1
	enemies_killed_changed.emit(enemies_killed,target_kills)
	if enemies_killed >= target_kills:
		has_won()

func has_won():
	if game_finished:
		return
	game_finished = true
	victory.emit()

func _on_player_died():
	if game_finished:
		return
	game_finished = true
	game_over.emit()
