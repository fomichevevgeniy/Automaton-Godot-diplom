extends Label


onready var NAMES_TABLE = {
	Global.GameClasses.ASSASIN: "АССАСИН",
	Global.GameClasses.ARCHER: "ЛУЧНИК",
	Global.GameClasses.BARBARIAN: "ВАРВАР",
	Global.GameClasses.MAGE: "МАГ"
	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = GlobalTranslator.get_text(NAMES_TABLE[Global.persontype], GlobalTranslator.current_lang)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
