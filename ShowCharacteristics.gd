extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var characteristics = [Global.health, Global.strength, Global.agility, Global.intellect]
	var show = GlobalTranslator.get_text("_statsforlevel_", GlobalTranslator.current_lang)
	self.text = show % characteristics



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
