#Скрипт панельки настройки алгоритма

extends Control


signal algorithm_started(start_state, algorithm)
signal algorithm_loaded(index, start_state, algorithm)
signal current_player_changed(index)

var start_state: int

#Установка начального состояния

func _on_LineEdit_text_entered(new_text):
	start_state = int(new_text)

#Добавление строки в алгоритм

func _on_AddFragment_pressed():
	$ScrollContainer/VBoxContainer.add_child(load("res://AutomatonMode/Resources/Scenes/AlgorithmPart.tscn").instance())

#Сборка алгоритма из строк

func _on_StartAlgorithm_pressed():
	var algorithm: Array
	for i in $ScrollContainer/VBoxContainer.get_children():
		var fragment = (i as AlgorithmPart).get_fragment()
		if fragment.condition_directions == null: continue
		algorithm.append(fragment)
	emit_signal("algorithm_started", start_state, algorithm)

func _on_LoadAlgorithm_pressed():
	var algorithm: Array
	for i in $ScrollContainer/VBoxContainer.get_children():
		var fragment = (i as AlgorithmPart).get_fragment()
		if fragment.condition_directions == null: continue
		algorithm.append(fragment)
	AutomatManager.add_algorithm($Indexer.current_index, start_state, algorithm)

func load_algorithm(start_state_, algorithm):
	$ScrollContainer/VBoxContainer.clear()
	start_state = start_state_
	$LineEdit.text = str(start_state)
	for i in algorithm:
		var part = load("res://AutomatonMode/Resources/Scenes/AlgorithmPart.tscn").instance()
		$ScrollContainer/VBoxContainer.add_child(part)
		part.load_fragment(i)

#Сохранение

func save(path: String):
	var fs: File = File.new()
	
	var data: String = ""
	
	data += ("{0}"+"\n").format({"0": start_state})
	
	for i in $ScrollContainer/VBoxContainer.get_children():
		var fragment = (i as AlgorithmPart).get_fragment()
		if fragment.condition_directions == null: continue
		data += ("{0}"+"\n").format({"0": fragment})
	
	fs.open(path, File.WRITE)
	fs.store_string(data)
	fs.close()

#Загрузка

func load_save(path: String):
	var fs: File = File.new()
	
	fs.open(path, File.READ)
	
	var data: String = fs.get_as_text()
	
	var splited_data = data.split("\n")
	
	start_state = int(splited_data[0])
	$LineEdit.text = str(start_state)
	
	var i = 1
	
	while(i < splited_data.size()-1):
		var part = load("res://AutomatonMode/Resources/Scenes/AlgorithmPart.tscn").instance()
		$ScrollContainer/VBoxContainer.add_child(part)
		(part as AlgorithmPart).d_parse(splited_data[i])
		
		i += 1
	
	fs.close()

func update_automats_count(new_count):
	$Indexer.max_index = new_count-1

func update_current_algorithm() -> int:
	_update_aglorithm($Indexer.get_current_index())
	return $Indexer.get_current_index()

func _update_aglorithm(index):
	var alg = AutomatManager.get_algorithm(index)
	load_algorithm(alg["start_state"],alg["algorithm"])
	emit_signal("current_player_changed", index)

func _on_Indexer_index_changed(new_index):
	_update_aglorithm(new_index)
