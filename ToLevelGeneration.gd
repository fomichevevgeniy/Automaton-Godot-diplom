extends TextureButton

var level_generation_scene = preload("res://LevelGeneration.tscn")
var loading_screen = preload("res://LoadingScreen.tscn")



func _on_TextureButton_pressed():
	var screen = loading_screen.instance()
	get_parent().add_child(screen)
	screen.appear()
	yield(get_tree().create_timer(0.1),"timeout")
	get_tree().change_scene_to(level_generation_scene)
