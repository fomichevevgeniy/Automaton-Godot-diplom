extends Button


func _ready():
	pass # Replace with function body.


func _on_Hero_button_up():
	get_tree().change_scene("res://ChoosePerson.tscn")
