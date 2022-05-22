extends ProjectTile

export var speed: float

func _physics_process(delta):
	move_local_x(delta*speed)

func _on_Area2D_body_entered(body: Living) -> void:
	._on_Area2D_body_entered(body)
	if body != attacker:
		queue_free()
