extends Resource

class_name SaveBuilder

var map = []
var player_positions = []
var algorithms = []

func set_map(map_):
	map = map_
	return (self as SaveBuilder)

func set_player_positions(player_positions_):
	player_positions = player_positions_
	return (self as SaveBuilder)

func set_algorithms(algorithms_):
	algorithms = algorithms_
	return (self as SaveBuilder)

func build():
	return SaveObj.new(map, player_positions, algorithms)
