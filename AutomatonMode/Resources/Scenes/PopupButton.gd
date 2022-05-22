#Замена Godot'овскому MenuButton, который не очень удобно работает
extends TextureButton

signal item_selected(id)

onready var popup: PopupMenu = get_child(0)

func _ready():
	popup.call_deferred("connect", "id_pressed", self, "_on_Popup_id_pressed")

#Устанавливает иконку от выбранного элемента, и активирует сигнал о выборе элемента
func _on_Popup_id_pressed(id):
	set_icon(id)
	emit_signal("item_selected", id)

func set_icon(id):
	texture_normal = popup.get_item_icon(int(id))

#Показывает выпадающий список
func _on_TextureButton_pressed():
	popup.rect_global_position = rect_global_position
	popup.popup()
