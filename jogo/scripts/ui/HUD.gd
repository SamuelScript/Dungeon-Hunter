class_name HUD extends CanvasLayer

@onready var health_bar: ProgressBar = $MarginContainer/MarginContainer/HealthBar
@onready var game_over: CenterContainer = $GameOver
@onready var victory: CenterContainer = $Victory
@onready var restart_button: Button = $GameOver/PanelContainer/VBoxContainer/Button
@onready var play_again: Button = $Victory/PanelContainer/VBoxContainer/Button
@onready var kill_counter: Label = $MarginContainer/MarginContainer/KillCounter
@onready var game_over_sound : AudioStreamPlayer = $GameOverSound
@onready var victory_sound : AudioStreamPlayer = $VictorySound
@onready var countdown: Label = $CenterContainer/CountDown
@onready var countdown_timer: Timer = $CenterContainer/CountDownTimer
@onready var pause_panel: CenterContainer = $PausePanel

var countdown_value := 3
var game_paused := false

var player: Player

func initialize(owner: Player):
	player = owner
	player.health.health_changed.connect(_on_health_changed)
	_on_health_changed(
		player.health.current_health,
		player.health.max_health
	)
	restart_button.pressed.connect(_on_restart_pressed)
	var game_manager = get_tree().get_first_node_in_group("game_manager")
	game_manager.game_over.connect(_on_player_died)
	game_manager.enemies_killed_changed.connect(_on_enemies_killed_changed)
	_on_enemies_killed_changed(0,game_manager.target_kills)
	game_manager.victory.connect(_on_victory)
	play_again.pressed.connect(_on_victory_restart_pressed)

func _ready() -> void:
	var game_manager = get_tree().get_first_node_in_group("game_manager")
	game_manager.countdown_started.connect(start_countdown)

func start_countdown() -> void:
	countdown_value = 3
	countdown.text = str(countdown_value)
	countdown.visible = true
	countdown_timer.start()

func _on_countdown_timer_timeout() -> void:
	if game_paused :
		return
	countdown_value -= 1
	if countdown_value <= 0:
		countdown.text = "LUTAR!"
		countdown_timer.stop()
		await get_tree().create_timer(0.5).timeout
		countdown.visible = false
		var game_manager = get_tree().get_first_node_in_group("game_manager")
		game_manager.begin_match()
		return
	countdown.text = str(countdown_value)

func _on_enemies_killed_changed(current: int,count_max:int):
	kill_counter.text = "Slimes: %d/%d" % [current,count_max]

func _on_health_changed(current: int, maximum: int):
	health_bar.max_value = maximum
	health_bar.value = current

func _on_victory():
	victory.visible = true
	victory_sound.play()
	get_tree().paused = true

func _on_player_died():
	game_over.visible = true
	game_over_sound.play()
	get_tree().paused = true

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_victory_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_resume_button_pressed() -> void:
	toggle_pause()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause() -> void:
	game_paused = not game_paused
	pause_panel.visible = game_paused
	get_tree().paused = game_paused
