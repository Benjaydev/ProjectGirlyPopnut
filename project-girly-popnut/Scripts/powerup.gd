class_name Powerup extends RigidBody2D

@export var effectDuration : float = 10
@export var rigidBody : RigidBody2D
@export var player : Player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(_delta: float) -> void:
	if (!visible):
		return
		
	var colliders = rigidBody.get_colliding_bodies()
	if (len(colliders) > 0):
		for col in colliders:
			if col == player && col is Player:
				col.AddPowerup(effectDuration)
				visible = false
				return
