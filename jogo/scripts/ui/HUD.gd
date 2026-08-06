class_name HUD extends CanvasLayer

@onready var health_bar: ProgressBar = $MarginContainer/HealthBar

var player: Player

func initialize(owner: Player):
	player = owner
	player.health.health_changed.connect(_on_health_changed)
	_on_health_changed(
		player.health.current_health,
		player.health.max_health
	)
func _on_health_changed(current: int, maximum: int):
	health_bar.max_value = maximum
	health_bar.value = current
