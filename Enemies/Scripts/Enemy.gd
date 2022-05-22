extends Living

class_name Enemy

export var base_health: float

func _ready():
	._ready()
	_generate_stats()

func _physics_process(delta):
	._physics_process(delta)
	if Global.player != null:
		_AI(Global.player)
	
func _AI(target: Living):
	pass

func _generate_stats():
	var mid = (Global.gamestrength + Global.gameintellect + Global.gameagility)/3
	
	max_health = base_health * (Global.gamehealth/10)
	strength = Global.random.randi_range(1,mid) * 3
	agility = Global.random.randi_range(1,mid) * 3
	intellect = Global.random.randi_range(1,mid) * 3

func _die():
	._die()
	queue_free()
