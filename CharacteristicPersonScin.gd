extends TextureRect

const PORTRAITS_TABLE = {
	Global.GameClasses.ASSASIN: "res://resources/images/MenuInterface/Heroes/assasin.png",
	Global.GameClasses.ARCHER: "res://resources/images/MenuInterface/Heroes/archer.png",
	Global.GameClasses.BARBARIAN: "res://resources/images/MenuInterface/Heroes/barbarian.png",
	Global.GameClasses.MAGE: "res://resources/images/MenuInterface/Heroes/magican.png"
	
}


func _ready():
	self.texture = load(PORTRAITS_TABLE[Global.persontype])
	self.rect_scale = Vector2(0.5, 0.5)
	if Global.persontype in [Global.GameClasses.BARBARIAN, Global.GameClasses.MAGE]:
		self.rect_position = Vector2(450, 0)
		return
	self.rect_position = Vector2(350, 0)


func _on_straight_plus_pressed():
	pass # Replace with function body.
