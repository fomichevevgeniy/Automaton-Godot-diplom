extends Living

class_name Character

var state_blocked = false

onready var class_table = {
	Global.GameClasses.ARCHER: "res://PlayerAttacks/ArcherAttacker.gd",
	Global.GameClasses.ASSASIN: "res://PlayerAttacks/BarbarianAttacker.gd",
	Global.GameClasses.BARBARIAN: "res://PlayerAttacks/BarbarianAttacker.gd",
	Global.GameClasses.MAGE: "res://PlayerAttacks/MageAttacker.gd"
}

onready var sprite_table = {
	Global.GameClasses.ARCHER: load("res://HeroSkins/Archer/ArcherFrames.tres"),
	Global.GameClasses.ASSASIN: load("res://HeroSkins/Assasin/AssasinFrames.tres"),
	Global.GameClasses.BARBARIAN: load("res://HeroSkins/Barbarian/BarbarianFrames.tres"),
	Global.GameClasses.MAGE: load("res://HeroSkins/Mage/MageFrames.tres")
}

###Мой Кусок{

func _level_up() -> void:
	Global.gamehealth += Global.health
	Global.gameagility += Global.agility
	Global.gamestrength += Global.strength
	Global.gameintellect += Global.intellect
	
	_update_stats()

func _update_stats() -> void:
	health = Global.gamehealth * 10
	max_health = health
	agility = Global.gameagility * 5
	strength = Global.gamestrength * 5
	intellect = Global.gameintellect * 5

func _apply_class():
	add_child(load(class_table[Global.persontype]).new())
	$Sprite.frames = sprite_table[Global.persontype]
###}


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				$Camera2D.zoom = $Camera2D.zoom - Vector2(0.1, 0.1)
			if event.button_index == BUTTON_WHEEL_DOWN:
				$Camera2D.zoom = $Camera2D.zoom + Vector2(0.1, 0.1)

func _get_input():
	velocity = Vector2()
	if state_blocked: 
		return
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	
	velocity = velocity.normalized() * speed
	
	if velocity == Vector2.ZERO:
		$Sprite.play("Idle")
	else:
		$Sprite.play("Run")
		if velocity.x == 0: return
		$Sprite.flip_h = velocity.x < 0

func _take_damage(attacker: Living) -> AttackResult:
	state_blocked = true
	$Sprite.play("Hit")
	yield($Sprite, "animation_finished")
	state_blocked = false
	return ._take_damage(attacker)

func _ready():
	._ready()
	Global.player = self
	_apply_class()
	_level_up()
	_update_stats()
	
func _physics_process(delta):
	_get_input()
	._physics_process(delta)
