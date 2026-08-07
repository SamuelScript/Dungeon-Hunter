class_name EnemySpawner extends Node2D

const SLIME_SCENE = preload("res://scenes/entities/Slime.tscn")

@onready var entities: Node2D = $"../Entities"
@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_point: Marker2D = $SpawnPoint

var current_enemy: Slime = null

func _ready():
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_enemy()

func spawn_enemy():
	current_enemy = SLIME_SCENE.instantiate()
	entities.add_child(current_enemy)
	current_enemy.global_position = spawn_point.global_position
	current_enemy.tree_exited.connect(_on_enemy_died)
	current_enemy.brain.target = get_tree().get_first_node_in_group("player")

func _on_enemy_died():
	current_enemy = null
	spawn_timer.start()

func _on_spawn_timer_timeout():
	spawn_enemy()
