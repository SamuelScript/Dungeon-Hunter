class_name Slime extends Entity

func _ready() -> void:
	super()
	movement.speed = 70

func _physics_process(delta):
	brain.update()
	velocity = movement.get_velocity()
	move_and_slide()
