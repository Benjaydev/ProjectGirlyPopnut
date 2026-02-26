extends Node2D

@export var enemyTypes : Dictionary[String, PackedScene]

@export var roundConfigs : Dictionary[int, EnemySpawnConfigList]
@export var currentRound : int = 0

var spawnAreas : Array[EnemySpawnArea] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnAreas = GetAreas(self)

func GetAreas(node):
	var areas : Array[EnemySpawnArea] = []
	for child in node.get_children():
		if child is EnemySpawnArea:
			areas.append(child)
		else:
			areas += GetAreas(child)
			
	return areas

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	for config : EnemySpawnConfig in roundConfigs[currentRound].list:
		var finished : bool = config.AddTime(delta)
		
		if(finished && config.enemyType in enemyTypes.keys()):
			SpawnEnemyInValid(config.enemyType)
			

			
func SpawnEnemyInValid(enemyType):
	var validAreas : Array[EnemySpawnArea] = []
	for area in spawnAreas:
		if enemyType in area.enemiesThatCanSpawn:
			validAreas.append(area)
			
	var rand : int = randi_range(0, len(validAreas)-1)
	
	var shape = validAreas[rand]
	var rect : Rect2 = shape.shape.shape.get_rect()
	var x = randi_range(int(rect.position.x), int(rect.position.x+rect.size.x))
	var y = randi_range(int(rect.position.y), int(rect.position.y+rect.size.y))
	var rand_point = shape.shape.global_position + Vector2(x,y)
	
	var enemy = enemyTypes[enemyType].instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = rand_point
	
