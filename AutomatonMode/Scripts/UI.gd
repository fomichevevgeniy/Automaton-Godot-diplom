extends CanvasLayer


var mouse_on_ui: bool setget , get_mouse_on_ui

func get_mouse_on_ui() -> bool:
	return Rect2($Interface/ColorRect.rect_position, $Interface/ColorRect.rect_size).has_point(get_viewport().get_mouse_position())

func _process(delta):
	GuiVariables.is_mouse_locked = get_mouse_on_ui()
