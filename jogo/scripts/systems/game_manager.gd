class_name GameManager extends Node

signal enemies_killed_changed(current: int,count_max:int)
signal victory()
signal game_over()
signal countdown_started()
signal match_started()

@export var target_kills: int = 5

var game_started := false
var enemies_killed := 0
var game_finished := false

func _ready() -> void:
	add_to_group("game_manager")
	call_deferred("start_match")

func start_match() -> void:
	if game_started or game_finished:
		return
	countdown_started.emit()

func begin_match() -> void:
	if game_started or game_finished:
		return
	game_started = true
	match_started.emit()

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
