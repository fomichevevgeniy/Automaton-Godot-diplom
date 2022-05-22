extends Node

var algorithms = []
var automats = []

func add_algorithm(algorithm_index, start_state, algorithm):
	while algorithm_index > len(algorithms)-1:
		algorithms.append(null)
	algorithms[algorithm_index] = {
		"start_state": start_state,
		"algorithm": algorithm
	}

func load_algoritm_to_automat(automat,index):
	var alg_dict = algorithms[index]
	automat.load_algorithm(alg_dict["start_state"],alg_dict["algorithm"])

func save_algorithms(save_builder: SaveBuilder):
	return save_builder.set_algorithms(algorithms)

func load_algorithm_from_save(save: SaveObj):
	algorithms = save.algorithms

func get_algorithm(index) -> Dictionary:
	if not (index in range(0,len(algorithms))) or algorithms[index] == null:
		return {
			"start_state": 0,
			"algorithm": []
		}
	
	return algorithms[index]

func get_automats():
	return automats

func load_automats(automats_):
	automats = automats_

func remove_algorithm(algorithm_index):
	algorithms.remove(algorithm_index)
