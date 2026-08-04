extends Entity

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	
	movement.direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	velocity = movement.get_velocity()
	move_and_slide()
