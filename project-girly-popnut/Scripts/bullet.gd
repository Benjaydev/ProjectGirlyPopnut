class_name Bullet extends RigidBody2D

var packedSceneReference : PackedScene = null

var direction : Vector2 = Vector2.ZERO
var speed = 500

@export var lifetime : float = 2
var lifetimeCount = 0

var targetPosition = null
var targetVelocity = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if(visible):

		lifetimeCount+=delta
		if(lifetimeCount >= lifetime):
			GlobalManager.AddBulletToPool(self)
			visible = false
			linear_velocity = Vector2.ZERO
			freeze = true

func _integrate_forces(state : PhysicsDirectBodyState2D) -> void:
	if(targetPosition != null):
		state.transform.origin = targetPosition
		targetPosition = null
		lifetimeCount = 0
		visible = true



func Shoot(pos, dir):
	direction = dir	
	targetPosition = pos
	freeze = false
	linear_velocity = direction * speed
