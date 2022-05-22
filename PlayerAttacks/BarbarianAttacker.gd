extends PlayerAttacker

onready var trail = load("res://HitTrail.tscn")

const COOL_DOWN = 1.3

func attack(direction: Vector2):
	create_project_tile(trail, direction)
	
