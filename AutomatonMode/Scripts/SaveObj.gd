extends Resource

class_name SaveObj

var map = []
var player_positions = []
var algorithms = []

func _init(map_, player_positions_, algorithms_):
	map = map_
	player_positions = player_positions_
	algorithms = algorithms_

func to_dict():
	return {
		"map": map,
		"player_positions": player_positions,
		"algorithms": algorithms
	}
