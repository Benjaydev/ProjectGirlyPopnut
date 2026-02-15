class_name Character extends CharacterBody2D

@export var speed : float = 250
@export var maxHealth : float = 100
var health : float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Reset()
	pass # Replace with function body.

func Reset():
	health = maxHealth
	

func _physics_process(delta: float) -> void:
	move_and_slide()

func Damage(damage):
	health-=damage
	if(health <= 0):
		Kill()
	
func Kill():
	pass
