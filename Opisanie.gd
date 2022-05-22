extends Label


onready var DESCRIPTIONS_TABLE = {
	Global.GameClasses.ASSASIN: "_assasindescription_",

	Global.GameClasses.ARCHER: "_archerdesription_",

	Global.GameClasses.BARBARIAN: "_barbariandescription_",

	Global.GameClasses.MAGE: "_magedescription_"
}

func _ready():
	self.text = GlobalTranslator.get_text(DESCRIPTIONS_TABLE[Global.persontype],GlobalTranslator.current_lang)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
