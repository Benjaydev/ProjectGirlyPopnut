extends ProgressBar

@export var character : Character


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	value = character.health/character.maxHealth
