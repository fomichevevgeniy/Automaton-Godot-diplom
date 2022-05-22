extends Node2D

class_name Attacker

var can_attack: bool = true

func attack(direction: Vector2):
	pass

func create_project_tile(prefab: PackedScene, direction: Vector2) -> ProjectTile:
	var tile = (prefab.instance() as ProjectTile)
	get_tree().current_scene.add_child(tile)
	tile.set_attacker(get_parent()).set_direction(direction).global_position = global_position
	return tile
