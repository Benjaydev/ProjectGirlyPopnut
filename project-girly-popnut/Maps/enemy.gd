class_name Enemy extends Character


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var dir = (Player.Instance.global_position-global_position).normalized()
	velocity = dir*speed

	move_and_slide()
