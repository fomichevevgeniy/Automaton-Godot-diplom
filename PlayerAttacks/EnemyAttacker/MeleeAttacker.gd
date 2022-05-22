extends Attacker

onready var trail = load("res://HitTrail.tscn")

const COOL_DOWN = 1.3

func attack(direction: Vector2):
	if not can_attack: return
	can_attack = false
	create_project_tile(trail, direction)
	yield(get_tree().create_timer(COOL_DOWN),"timeout")
	can_attack = true
