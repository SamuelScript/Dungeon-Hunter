class_name Goblin extends Entity

const PROJECTILE_SCENE = preload("res://scenes/projectiles/goblin_projectile.tscn")

@onready var death_sound: AudioStreamPlayer = $DeathSound
@onready var damage_sound: AudioStreamPlayer = $DamageSound
@onready var attack_timer: Timer = $AttackTimer

func _ready() -> void:
	super()
	movement.speed = 50
	brain.attack_damage = 12
	var player := get_tree().get_first_node_in_group("player") as Entity
	if player != null:
		brain.set_target(player)

func _physics_process(_delta: float) -> void:
	if brain.target == null:
		return
	var direction = brain.get_direction(global_position)
	velocity = movement.get_velocity()
	move_and_slide()
	
	try_attack()

func try_attack() -> void:
	if brain.target == null:
		return
	if not attack_timer.is_stopped():
		return
	var distance := global_position.distance_to(brain.target.global_position)
	if distance < brain.minimum_distance:
		return
	if distance > brain.preferred_distance + 30.0:
		return
	var projectile = PROJECTILE_SCENE.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	var direction := global_position.direction_to(
		brain.target.global_position
	)
	projectile.set_direction(direction)
	attack_timer.start()

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
