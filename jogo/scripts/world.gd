extends Node2D

@onready var player: Player = $Entities/Player
@onready var player_spawn: Marker2D = $SpawnPoints/PlayerSpawn

@onready var slime: Slime = $Entities/Slime
@onready var slime_spawn: Marker2D = $SpawnPoints/SlimeSpawn

func _ready() -> void:
	player.global_position = player_spawn.global_position
	slime.global_position = slime_spawn.global_position
