class_name Player extends Character

@export var shootFromDistance = 40
@export var shootDelay = 0.1
var shootDelayTimer = 0;
@export var bulletPackedScene : PackedScene

static var Instance = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	Instance = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	super._physics_process(delta)
	shootDelayTimer+=delta


	if(Input.is_action_pressed("Shoot")):
		if(shootDelayTimer >= shootDelay):
			var singleFrameShots = floor(shootDelayTimer/shootDelay)
			for i in range(singleFrameShots):
				Shoot()
	
func Shoot():
	var bullet = GlobalManager.SpawnBullet(bulletPackedScene)
			
	var mouse_pos: Vector2 = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()
	bullet.Shoot(global_position+dir*shootFromDistance, dir)
	shootDelayTimer = 0
	

	
