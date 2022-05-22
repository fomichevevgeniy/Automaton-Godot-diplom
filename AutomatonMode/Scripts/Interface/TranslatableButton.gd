extends Button

class_name TranslatableButton

var true_text

func _ready():
	true_text = text
	GlobalTranslator.connect("language_changed", self, "translate")
	translate(GlobalTranslator.current_lang)

func translate(lang):
	text = GlobalTranslator.get_text(true_text, lang)
