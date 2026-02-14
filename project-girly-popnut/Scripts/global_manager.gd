extends Node

var inactiveBulletPool = {}


func SpawnBullet(packedScene) -> Bullet:
	if(packedScene == null):
		return
		
	var key = packedScene.get_path()
	if inactiveBulletPool.has(key):
		var poolArray : Array = inactiveBulletPool[key]
		if(len(poolArray) != 0):
			var bullet = poolArray[-1]
			inactiveBulletPool[key].pop_back()
			return bullet
	else:
		inactiveBulletPool[key] = []

	var bullet = packedScene.instantiate()
	bullet.packedSceneReference = packedScene
	add_child(bullet)
	return bullet	

func AddBulletToPool(bullet):
	var key = bullet.packedSceneReference.get_path()
	if(!inactiveBulletPool.has(key)):
		inactiveBulletPool[key] = [bullet]
		return
		
	inactiveBulletPool[key].append(bullet)
