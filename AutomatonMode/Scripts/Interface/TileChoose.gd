extends Control

tool

var old_size: Vector2 = Vector2(320,180)

signal tile_selected(id)

#Это чтобы UI элемент в редакторе удобно было растягивать
func _on_TileChoose_resized():
	$TileMap.scale = rect_size * 3 / len($TileMap.get_used_cells()) / old_size
	$TileMap.position = Vector2(12, 48) * $TileMap.scale


#Выбор тайла по клику, активация сигнала
func _on_TileChoose_gui_input(event):
	if not Engine.is_editor_hint():
		if event.is_action_pressed("left_click"):
			var id = $TileMap.get_cellv($TileMap.world_to_map(event.position / $TileMap.scale -$TileMap.position))
			if id != -1:
				emit_signal("tile_selected", id)
