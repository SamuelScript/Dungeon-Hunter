extends Node2D

@onready var player: Player = $Entities/Player
@onready var player_spawn: Marker2D = $SpawnPoints/PlayerSpawn

func _ready() -> void:
	player.health.died.connect(($GameManager)._on_player_died)
	player.global_position = player_spawn.global_position
