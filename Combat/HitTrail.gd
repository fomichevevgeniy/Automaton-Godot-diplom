extends ProjectTile

func _ready():
	$AnimationPlayer.play("Hit")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
