extends FileDialog

var pr_s = false

func _process(delta):
	if not visible and pr_s:
		emit_signal("popup_hide")
		pr_s = false
	if visible and not pr_s:
		pr_s = true


func _on_Load_pressed():
	get_tree().paused = true
	show()
	invalidate()
