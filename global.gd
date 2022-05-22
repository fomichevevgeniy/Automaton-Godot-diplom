extends Node

enum GameClasses {
	NULL,
	ASSASIN,
	ARCHER,
	BARBARIAN,
	MAGE,
	DRUID,
	NECROMANCER,
	CLERIC,
	PALADIN,
	WARRIOR
}

# Переменные для увеличения характеристик игрока
var persontype = GameClasses.NULL
var health = 0
var strength = 0
var agility = 0
var intellect = 0
var startpoints = 25
# Стартовые и меняющиеся на протяжении переменные

var gamehealth = 10
var gamestrength = 10
var gameagility = 10
var gameintellect = 10

var level = 1

var random:RandomNumberGenerator = RandomNumberGenerator.new()

var player

var mob_pool = [preload("res://Enemies/Scenes/Undead.tscn")]

# за 1 ед health - 10 здоровья
# за 1 ед strength - + 5 урон
# за 1 ед agility - + 5 ловкости что в сообношении с противником дает шанс уклона
# за 1 ед intellect - + 5 интеллекта что в соотношении к противнику дает шанс крита и коэф прибавки опыта

# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()

func get_mob() -> Enemy:
	random.randomize()
	var mob = (mob_pool[random.randi_range(0,len(mob_pool)-1)].instance() as Enemy)
	return mob


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
