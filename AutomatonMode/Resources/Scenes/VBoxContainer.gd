extends VBoxContainer


func clear():
	for i in get_children():
		i.queue_free()
