extends TranslatableButton

var playing: bool = false

func switch_playing_status(status: bool):
	playing = status
	true_text = "Стоп" if status else "Старт"
	translate(GlobalTranslator.current_lang)
