class_name EnemySpawner extends Node2D

const SLIME_SCENE = preload("res://scenes/entities/Slime.tscn")

@onready var entities: Node2D = $"../Entities"
@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_points := $SpawnPoints.get_children()

@export var spawn_distance: float = 32.0
@export var max_enemies: int = 3
@export var spawn_interval: float = 2.0

var enemies: Array[Slime] = []

func _ready():
	spawn_timer.wait_time = spawn_interval
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	for i in range(max_enemies):
		spawn_enemy()

func spawn_enemy():
	if enemies.size() >= max_enemies:
		return
	
	var enemy : Slime = SLIME_SCENE.instantiate()
	if randf() < 0.25:
		enemy.is_fast = true
	
	entities.add_child(enemy)
	
	var spawn_position = get_spawn_position()
	if spawn_position == Vector2.INF:
		enemy.queue_free()
		return
	enemy.global_position = spawn_position
	
	enemies.append(enemy)
	
	enemy.tree_exited.connect(_on_enemy_died.bind(enemy))
	enemy.brain.target = get_tree().get_first_node_in_group("player")

func _on_enemy_died(enemy:Slime):
	if enemy in enemies:
		enemies.erase(enemy)
	$"../GameManager".enemy_killed()
	if spawn_timer.is_stopped():
		spawn_timer.start()

func _on_spawn_timer_timeout():
	spawn_enemy()

func get_spawn_position() -> Vector2:
	var available_points = spawn_points.duplicate()
	available_points.shuffle()
	for point in available_points:
		var valid := true
		for enemy in enemies:
			if is_instance_valid(enemy):
				if point.global_position.distance_to(enemy.global_position) < spawn_distance:
					valid = false
					break
		if valid:
			return point.global_position
	return Vector2.INF
