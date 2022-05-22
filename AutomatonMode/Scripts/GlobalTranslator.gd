extends Node

signal language_changed(lang)

const langs = {
	"ru": "res://Langs/ru_ru.json",
	"en": "res://Langs/ru_en.json"
}

var current_lang = "ru"

func _ready():
	var file = File.new()
	if not file.file_exists("user://lang.ls"):
		file.open("user://lang.ls", File.WRITE)
		file.store_string(current_lang)
		file.close()
		return
	file.open("user://lang.ls", File.READ)
	change_language(file.get_as_text())
	file.close()

func get_text(text, lang) -> String:
	var file = File.new()
	file.open(langs[lang],File.READ)
	var result = JSON.parse(file.get_as_text()).result[text]
	file.close()
	return result

func change_language(lang):
	current_lang = lang
	emit_signal("language_changed",lang)
	var file = File.new()
	file.open("user://lang.ls", File.WRITE)
	file.store_string(current_lang)
	file.close()
