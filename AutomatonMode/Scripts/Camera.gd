extends Camera2D

var prev_mouse_pos: Vector2
var mouse_delta: Vector2

func _process(delta):
	mouse_delta = get_viewport().get_mouse_position() - prev_mouse_pos
	prev_mouse_pos = get_viewport().get_mouse_position()
	
	if GuiVariables.is_mouse_locked: return
	
	if Input.is_action_pressed("grab_mouse"):
		if Input.is_action_pressed("left_click"):
			position -= mouse_delta * zoom

	if Input.is_action_just_released("scroll_down"):
		var prev_pos = get_global_mouse_position()
		zoom += Vector2.ONE * 0.1
		position -= get_global_mouse_position() - prev_pos

	if Input.is_action_just_released("scroll_up"):
		var prev_pos = get_global_mouse_position()
		zoom -= Vector2.ONE * 0.1
		position -= get_global_mouse_position() - prev_pos
