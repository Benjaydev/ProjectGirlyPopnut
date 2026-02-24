class_name Bullet extends RigidBody2D

@export var speed = 500
@export var damage = 30
@export var lifetime : float = 2
@export var rigidBody : RigidBody2D 

var packedSceneReference : PackedScene = null
var direction : Vector2 = Vector2.ZERO
var lifetimeCount = 0
var targetPosition = null
var targetVelocity = null
var shotFrom : Character = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if(visible):
		var colliders = rigidBody.get_colliding_bodies()
		if(len(colliders) > 0):
			for col in colliders:
				if col != shotFrom && col is Character:
					col.Damage(damage)
					End()
					return
		
		
		lifetimeCount+=delta
		if(lifetimeCount >= lifetime):
			End()

func End():
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

func Shoot(pos, dir, shooter):
	shotFrom = shooter
	direction = dir
	targetPosition = pos
	freeze = false
	linear_velocity = (direction * speed) + shooter.velocity
