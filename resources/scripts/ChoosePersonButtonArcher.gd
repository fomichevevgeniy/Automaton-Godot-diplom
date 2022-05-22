extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	connect("mouse_entered", self, "_on_Button_mouse_entered")
	connect("mouse_exited", self, "_on_Button_mouse_exited")
	

# Called when the node enters the scene tree for the first time.

func _on_Button_mouse_entered():

	$TextureRect.rect_scale = Vector2(0.32, 0.32)
	$Label.rect_scale = Vector2(1.1, 1.1)
	$Archer.visible = true
	$Particles2D.emitting = true
	

func _on_Button_mouse_exited():

	$TextureRect.rect_scale = Vector2(0.3, 0.3)
	$Label.rect_scale = Vector2(1.0, 1.0)
	$Archer.visible = false
	$Particles2D.emitting = false


func _on_ArcherButton_pressed():
	Global.persontype = Global.GameClasses.ARCHER
	Global.health = 1
	Global.strength = 3
	Global.agility = 1
	Global.intellect = 2
	get_tree().change_scene("res://CharacteristicsScene.tscn")
