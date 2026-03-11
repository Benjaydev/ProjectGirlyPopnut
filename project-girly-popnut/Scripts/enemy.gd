class_name Enemy extends Character


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(_delta: float) -> void:
	if is_instance_valid(Player.Instance):  
		var dir = (Player.Instance.global_position-global_position).normalized()
		velocity = dir*speed

		move_and_slide()
