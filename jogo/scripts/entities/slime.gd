class_name Slime extends Entity

@export var is_fast := false

@onready var death_sound: AudioStreamPlayer = $DeathSound
@onready var damage_sound: AudioStreamPlayer = $DamageSound
@onready var attack_timer: Timer = $AttackTimer

func _ready() -> void:
	super()
	if is_fast:
		movement.speed = 95
		health.max_health = 35
		brain.attack_damage = 8
	else:
		movement.speed = 70
		health.max_health = 50
	
	health.restore()
	attack_timer.timeout.connect(_on_attack_timer_timeout)

func _physics_process(delta):
	brain.update()
	velocity = movement.get_velocity()
	move_and_slide()
	try_attack()

func try_attack():
	if brain.target == null:
		return
	var distance = global_position.distance_to(brain.target.global_position)
	if distance > 20:
		return
	if attack_timer.is_stopped():
		brain.target.receive_damage(brain.attack_damage)
		attack_timer.start()

func _on_attack_timer_timeout():
	pass

func _on_died():
	super()
	death_sound.reparent(get_tree().current_scene)
	death_sound.finished.connect(death_sound.queue_free)
	death_sound.play()
	modulate = Color(1.0,0.3,0.3)
	await get_tree().create_timer(0.1).timeout
	queue_free()

func receive_damage(amount: int):
	var previous_health = health.current_health
	super(amount)
	if health.current_health < previous_health:
		damage_sound.play()
