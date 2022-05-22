extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.


func appear():
	$ProgressBar.value=0
	$AnimationPlayer.play("Appear")


func _on_TileMap_bitmask_updating_progressed(precentage):
	$ProgressBar.value=precentage


func _on_TileMap_bitmask_updated():
	$AnimationPlayer.play_backwards("Appear")
	yield($AnimationPlayer,"animation_finished")
