extends Entity

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	
	var direction_on_x := Input.get_axis("ui_left", "ui_right")
	if direction_on_x:
		velocity.x = direction_on_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var direction_on_y := Input.get_axis("ui_up", "ui_down")
	if direction_on_y:
		velocity.y = direction_on_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
