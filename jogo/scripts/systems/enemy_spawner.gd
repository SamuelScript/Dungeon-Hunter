class_name EnemySpawner extends Node2D

const SLIME_SCENE = preload("res://scenes/entities/Slime.tscn")

@onready var entities: Node2D = $"../Entities"
@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_points := $SpawnPoints.get_children()

@export var max_enemies: int = 3
@export var spawn_interval: float = 2.0

var alive_enemies: int = 0
var current_enemy: Slime = null

func _ready():
	spawn_timer.wait_time = spawn_interval
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	for i in range(max_enemies):
		spawn_enemy()

func spawn_enemy():
	if alive_enemies >= max_enemies:
		return
	current_enemy = SLIME_SCENE.instantiate()
	entities.add_child(current_enemy)
	alive_enemies += 1
	var point = spawn_points.pick_random()
	current_enemy.global_position = point.global_position
	current_enemy.tree_exited.connect(_on_enemy_died)
	current_enemy.brain.target = get_tree().get_first_node_in_group("player")

func _on_enemy_died():
	alive_enemies -= 1
	$"../GameManager".enemy_killed()
	current_enemy = null
	spawn_timer.start()

func _on_spawn_timer_timeout():
	spawn_enemy()
