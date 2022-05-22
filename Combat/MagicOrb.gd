extends ProjectTile

export var speed: float

func _physics_process(delta):
	move_local_x(delta*speed)

func boom():
	var expl = (load("res://MagicExplotion.tscn").instance() as ProjectTile)
	get_tree().current_scene.add_child(expl)
	expl.set_attacker(attacker).set_effects(effects).global_position = global_position

func _on_Area2D_body_entered(body: Living) -> void:
	if body in [null, attacker]: return
	$AnimationPlayer.play("Slowing")
	yield($AnimationPlayer, "animation_finished")
	boom()
	queue_free()
