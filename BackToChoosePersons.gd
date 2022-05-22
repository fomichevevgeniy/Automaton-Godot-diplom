extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _on_BackTomainmenuButton_button_up():
	Global.startpoints = 25
	Global.gamehealth = 10
	Global.gamestrength = 10
	Global.gameagility = 10
	Global.gameintellect = 10
	
	get_tree().change_scene("res://ChoosePerson.tscn")
	

