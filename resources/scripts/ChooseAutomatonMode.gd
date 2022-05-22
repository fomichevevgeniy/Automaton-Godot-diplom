extends Button


func _ready():
	pass # Replace with function body.

func _on_Automaton_button_up():
	$AudioStreamPlayer.play()
	get_tree().change_scene("res://Automaton.tscn")
