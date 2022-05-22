extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
# warning-ignore:return_value_discarded
	connect("mouse_entered", self, "_on_Button_mouse_entered")
# warning-ignore:return_value_discarded
	connect("mouse_exited", self, "_on_Button_mouse_exited")
	

# Called when the node enters the scene tree for the first time.

func _on_Button_mouse_entered():

	$TextureRect.rect_scale = Vector2(0.32, 0.32)
	$Label.rect_scale = Vector2(1.1, 1.1)
	$Magican.visible = true
	$Particles2D.emitting = true
	

func _on_Button_mouse_exited():

	$TextureRect.rect_scale = Vector2(0.3, 0.3)
	$Label.rect_scale = Vector2(1.0, 1.0)
	$Magican.visible = false
	$Particles2D.emitting = false


func _on_MagicanButton_pressed():
	Global.persontype = Global.GameClasses.MAGE
	Global.health = 2
	Global.strength = 1
	Global.agility = 1
	Global.intellect = 3
	get_tree().change_scene("res://CharacteristicsScene.tscn")
