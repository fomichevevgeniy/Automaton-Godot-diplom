extends Sprite


signal player_interacted



func _on_Area2D_body_entered(body: Character):
	if body != null:
		emit_signal("player_interacted")
		emit_signal("player_interacted")
