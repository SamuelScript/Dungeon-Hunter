class_name Sword extends Weapon

@onready var timer: Timer = $Timer
var attacking := false

func attack():
	if attacking:
		return
	attacking = true
	rotation = deg_to_rad(45)
	timer.start()

func _on_timer_timeout():
	rotation = 0
	attacking = false
