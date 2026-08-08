class_name Slime extends Entity

@export var is_fast := false

@onready var attack_timer: Timer = $AttackTimer

func _ready() -> void:
	super()
	if is_fast:
		movement.speed = 95
		health.max_health = 50
		brain.attack_damage = 15
	else:
		movement.speed = 70
	
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
	queue_free()
