class_name HUD extends CanvasLayer

@onready var health_bar: ProgressBar = $MarginContainer/HealthBar
@onready var game_over: CenterContainer = $GameOver
@onready var victory: CenterContainer = $Victory
@onready var restart_button: Button = $GameOver/PanelContainer/VBoxContainer/Button
@onready var play_again: Button = $Victory/PanelContainer/VBoxContainer/Button
@onready var kill_counter: Label = $MarginContainer/KillCounter

var player: Player

func initialize(owner: Player):
	player = owner
	player.health.health_changed.connect(_on_health_changed)
	_on_health_changed(
		player.health.current_health,
		player.health.max_health
	)
	player.health.died.connect(_on_player_died)
	restart_button.pressed.connect(_on_restart_pressed)
	var game_manager = get_tree().get_first_node_in_group("game_manager")
	game_manager.enemies_killed_changed.connect(_on_enemies_killed_changed)
	_on_enemies_killed_changed(0)
	game_manager.victory.connect(_on_victory)
	play_again.pressed.connect(_on_victory_restart_pressed)

func _on_enemies_killed_changed(current: int):
	kill_counter.text = "Slimes: %d/10" % current

func _on_health_changed(current: int, maximum: int):
	health_bar.max_value = maximum
	health_bar.value = current

func _on_victory():
	victory.visible = true

func _on_player_died():
	game_over.visible = true
func _on_restart_pressed():
	get_tree().reload_current_scene()
func _on_victory_restart_pressed():
	get_tree().reload_current_scene()
