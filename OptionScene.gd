extends Control

const LANGS = {
	0: "ru",
	1: "en"
}

func _ready():
	$LanguageChoose.set_icon(LANGS.values().find(GlobalTranslator.current_lang))

func _on_ToDirectionChoose_item_selected(id):
	GlobalTranslator.change_language(LANGS[int(id)])
