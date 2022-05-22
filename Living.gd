extends KinematicBody2D

class_name Living

signal died

export var id = 0
export var speed = 250

var additive_velocity = Vector2()
var velocity = Vector2()

var max_health: float
var health: float
var agility: float
var strength: float
var intellect: float

func _physics_process(delta):
	velocity = move_and_slide(velocity+additive_velocity)
	additive_velocity.linear_interpolate(Vector2.ZERO, 0.1)

func _ready():
	yield(get_tree(),"idle_frame")
	health = max_health

func kick(direction: Vector2) -> void:
	additive_velocity = direction

func take_attack(attacker: Living) -> AttackResult:
	if Global.random.randf_range(1,100) <= agility:
		return _take_damage(attacker)
	else:
		print("miss")
	return AttackResult.new(attacker, self, 0.0, 0.0)

func _take_damage(attacker: Living) -> AttackResult:
	if attacker == null: return AttackResult.new(null, self, 0, 0)
	var base_damage: float
	var critical_damage: float
	base_damage = attacker.strength
	if Global.random.randf_range(1,100) <= attacker.intellect:
		print("crit!!")
		critical_damage = base_damage*(attacker.intellect/max_health)#Крит, который неизвестно как считать
	health -= base_damage + critical_damage
	if health <= 0:
		# Добавить выбор 
		_die()
	print(health)
	return AttackResult.new(attacker, self, base_damage, critical_damage)

func _die():
	emit_signal("died")
