extends Node


func vec2_to_dict(vec: Vector2) -> Dictionary:
	return {
		"x": vec.x,
		"y": vec.y
	}

func algorithm_fragment_to_dict(part):
	if part == null: return null
	return {
		"see_condition": part.see_condition,
		"condition_directions": part.condition_directions,
		"condition_state": part.condition_state,
		"to_state": part.to_state,
		"to_direction": vec2_to_dict(part.to_direction),
		"see_radius": part.see_radius
	}

func algorithm_to_dict(algorithm):
	var result = {
		"start_state": algorithm["start_state"],
		"algorithm": []
	}
	for i in algorithm["algorithm"]:
		result["algorithm"].append(algorithm_fragment_to_dict(i))
	return result

func save_to_dict(save):
	var map = []
	for i in save.map:
		map.append(vec2_to_dict(i))
	var player_positions = []
	for i in save.player_positions:
		player_positions.append(vec2_to_dict(i))
	var algorithms = []
	for i in save.algorithms:
		algorithms.append(algorithm_to_dict(i))
	return {
		"map": map,
		"player_positions": player_positions,
		"algorithms": algorithms
	}

func save_to_json(save):
	return to_json(save_to_dict(save))

func vec2_from_dict(dict):
	return Vector2(dict["x"], dict["y"])
func algorithm_fragment_from_dict(dict):
	return AlgorithmFragment.new(dict["condition_state"], dict["see_condition"], dict["condition_directions"], dict["to_state"], vec2_from_dict(dict["to_direction"]), dict["see_radius"])
func algorithm_from_dict(dict):
	var result = {
		"start_state": dict["start_state"],
		"algorithm": []
	}
	for i in dict["algorithm"]:
		result["algorithm"].append(algorithm_fragment_from_dict(i))
	return result
func save_from_dict(dict):
	var map = []
	for i in dict["map"]:
		map.append(vec2_from_dict(i))
	var player_positions = []
	for i in dict["player_positions"]:
		player_positions.append(vec2_from_dict(i))
	var algorithms = []
	for i in dict["algorithms"]:
		 algorithms.append(algorithm_from_dict(i))
	return SaveObj.new(map, player_positions, algorithms)
func save_from_json(json_s):
	return save_from_dict(parse_json(json_s))
