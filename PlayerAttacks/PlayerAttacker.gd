extends Attacker

class_name PlayerAttacker

func _physics_process(delta):
	if Input.is_action_pressed("left_click"):
		if get_parent().state_blocked: return
		get_parent().state_blocked = true
		get_parent().get_node("Sprite").play("Attack")
		yield(get_parent().get_node("Sprite"), "animation_finished")
		attack(global_position.direction_to(get_global_mouse_position()))
		get_parent().state_blocked = false
