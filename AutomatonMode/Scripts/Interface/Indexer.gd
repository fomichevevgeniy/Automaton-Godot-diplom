extends Control

signal index_changed(new_index)
signal max_index_changed(new_max_index)

export(int) var max_index setget set_max_index

var current_index setget , get_current_index

var _current_index = 0

func set_max_index(value):
	if value < 0:
		max_index = 0
		_current_index = 0
		return
	max_index = value
	if _current_index > max_index:
		_current_index = max_index
	emit_signal("max_index_changed", max_index)

func get_current_index():
	return _current_index


func _on_RightButton_pressed():
	if _current_index == max_index: return
	_current_index += 1
	print(_current_index)
	emit_signal("index_changed", _current_index)


func _on_LeftButton_pressed():
	if _current_index == 0: return
	
	_current_index -= 1
	print(_current_index)
	emit_signal("index_changed", _current_index)
