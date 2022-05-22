extends ProjectTile

func _ready():
	$AnimationPlayer.play("Grow")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
