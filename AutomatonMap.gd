extends Node2D


const PLAYER_ID = 2
const EXCEPT_IDS = [0]
const MAP_SAVE_PATH = "user://AutomatonSave.save"
const ALGORITHM_SAVE_PATH = "user://AutomatonAlgorithmSave.save"
onready var Map = $TileMap
onready var player_prefab = load("res://AutomatonMode/Resources/Scenes/Player.tscn")
var current_id: int = 0
var current_player: int
var is_player_processing: bool = false
var player_positions: Array = []
var players: Array = []



func _ready():
	make_map()
	print(GlobalTranslator.current_lang)

func _process(delta):
	
	if is_player_processing: return
	
	if Input.is_action_pressed('left_click'):
		
		#Чтобы не рисовало, пока зажат пробел, или пока мышь на панельке с интерфейсом
		if Input.is_action_pressed("grab_mouse") or GuiVariables.is_mouse_locked:
			return
		
		#Рисование
		if len(player_positions) > 0:
			$UI/Interface/ColorRect/AlgorithmInterface.visible = true
		else:
			$UI/Interface/ColorRect/AlgorithmInterface.visible = false
		var pos = get_global_mouse_position()
		print("Mouse Click at: ", pos)
		var tile_pos = Map.world_to_map(pos)
		var cell = Map.get_cellv(tile_pos)
		if current_id == PLAYER_ID:
			if not tile_pos in player_positions:
				player_positions.append(tile_pos)
				update_selection($UI/Interface/ColorRect/AlgorithmInterface.update_current_algorithm())
				$UI/Interface/ColorRect/AlgorithmInterface.update_automats_count(len(player_positions))
		else:
			if cell != PLAYER_ID:
				var index = player_positions.find(tile_pos)
				player_positions.remove(index)
				AutomatManager.remove_algorithm(index)
				update_selection($UI/Interface/ColorRect/AlgorithmInterface.update_current_algorithm())
				$UI/Interface/ColorRect/AlgorithmInterface.update_automats_count(len(player_positions))
				print('Что-то2', player_positions)
		
		Map.set_cellv(tile_pos, current_id)
		print("TM pos: ", pos)
		print("cell: ", cell)
	
	#Сохранение по сочетанию клавиш
	
	#Выход в меню
	if Input.is_key_pressed(KEY_ESCAPE):
		save(MAP_SAVE_PATH)
		$UI/Interface/ColorRect/AlgorithmInterface.save(ALGORITHM_SAVE_PATH)
		get_tree().change_scene("res://MainMenu.tscn")

func _draw():
	if len(player_positions) == 0: return
	if is_player_processing: return
	draw_rect(Rect2(Map.map_to_world(player_positions[current_player])-Vector2.ONE,Vector2.ONE*66),Color(1, 1, 1, 0.5),true) # Заливка цветом выделенного автомата для настройки

#Заполнение карты синими тайлами
func make_map():
	for x in range(-500, 500):
			for y in range(-500, 500):
				Map.set_cell(x, y, 0)
				
#Сохранение
func save(path: String):
	_on_Player_move_failed()
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(GlobalSerializer.save_to_json((AutomatManager.save_algorithms(SaveBuilder.new().set_map(Map.get_used_cells_by_id(1)).set_player_positions(player_positions)) as SaveBuilder).build()))
	file.close()

#Загрузка
func load_save(path: String):
	var file = File.new()
	file.open(path, File.READ)
	var a = parse_json(file.get_line())
	var save_ = GlobalSerializer.save_from_json(file.get_as_text())
	print(save_)
	file.close()
	player_positions = save_.player_positions
	AutomatManager.load_algorithm_from_save(save_)
	$UI/Interface/ColorRect/AlgorithmInterface.update_automats_count(len(player_positions))
	update_selection($UI/Interface/ColorRect/AlgorithmInterface.update_current_algorithm())
	for i in save_.map:
		Map.set_cellv(i, 1)
	for i in player_positions:
		Map.set_cellv(i,PLAYER_ID)
	
	

#Выбор тайла для рисования
func _on_TileChoose_tile_selected(id: int):
	current_id = id
	print(current_id)

#Создание на месте соответствующего тайла объекта игрока. Запуск алгоритма
func _on_AlgorithmInterface_algorithm_started(start_state, algorithm) -> void:
	if is_player_processing:
		_on_Player_move_failed()
		return
	
	if len(Map.get_used_cells_by_id(PLAYER_ID)) == 0: return
	
	$UI/Interface/ColorRect/AlgorithmInterface/StartAlgorithm.switch_playing_status(true)
	while len(players) < len(player_positions):
		players.append(null)
	for i in len(player_positions):
		var _map = []
		if Map.get_cellv(player_positions[i]+Vector2.UP) == 1: _map.append(3)
		if Map.get_cellv(player_positions[i]+Vector2.DOWN) == 1: _map.append(1)
		if Map.get_cellv(player_positions[i]+Vector2.LEFT) == 1: _map.append(2)
		if Map.get_cellv(player_positions[i]+Vector2.RIGHT) == 1: _map.append(0)
		var player = player_prefab.instance()
		add_child(player)
		player.start_colliding_map = _map
		player.position = Map.map_to_world(player_positions[i])
		AutomatManager.load_algoritm_to_automat(player, i)
		players[i] = player

		Map.set_cellv(Map.world_to_map(player.position), 0)
		is_player_processing = true
		update()
	AutomatManager.load_automats(players)
	for i in players:

		print('Автомат в цикле', i)
		i.start_algorithm1()

#Остановка работы игрока. Удаление объекта игрока, установка на его место соответствующего тайла
func _on_Player_move_failed():
	for i in len(players):
		if players[i] == null: continue
		Map.set_cellv(Map.world_to_map(players[i].position), PLAYER_ID)
		player_positions[i] = Map.world_to_map(players[i].position)
		players[i].queue_free()
	
	is_player_processing = false
	update()
	$UI/Interface/ColorRect/AlgorithmInterface/StartAlgorithm.switch_playing_status(false)

#Очистка поля
func _on_Clear_pressed():
	player_positions = []
	players = []
	make_map()

func update_selection(index):
	current_player = index
	print("current_player", current_player)
	update()

func _on_AlgorithmInterface_current_player_changed(index):
	update_selection(index)


