extends Node2D

@onready var world = $World
@onready var hud: HUD = $HUD

func _ready():
	hud.initialize(world.player)
