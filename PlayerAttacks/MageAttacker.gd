extends PlayerAttacker

onready var arrow = load("res://MagicOrb.tscn")

func attack(direction: Vector2):
	create_project_tile(arrow, direction)
	
