extends Entity

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	brain.update_input()
	velocity = movement.get_velocity()
	move_and_slide()
