extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$points/numbers.text = str(Global.startpoints)
	$health/Stats/Value.text = str(Global.gamehealth)
	$straight/Stats/Value.text = str(Global.gamestrength)
	$agility/Stats/Value.text = str(Global.gameagility)
	$Magic/Stats/Value.text = str(Global.gameintellect)
	$health/Stats/Change.text = '0'
	$straight/Stats/Change.text = '0'
	$agility/Stats/Change.text = '0'
	$Magic/Stats/Change.text = '0'
	$ResultHealth/Number.text = str(Global.gamehealth * 10)
	$ResultStraight/Number.text = str(Global.gamestrength * 5)
	$ResultAgility/Number.text = str(Global.gameagility * 5)
	$ResultMagic/Number.text = str(Global.gameintellect * 5)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_health_plus_pressed():
	if Global.startpoints != 0:
		Global.gamehealth = Global.gamehealth + 1
		Global.startpoints = Global.startpoints - 1
		$points/numbers.text = str(Global.startpoints)
		$health/Stats/Value.text = str(Global.gamehealth)
		$health/Stats/Change.text = str(Global.gamehealth - 10)
		$ResultHealth/Number.text = str(Global.gamehealth * 10)
	


func _on_health_minus_pressed():
	if Global.gamehealth != 0:
		Global.gamehealth = Global.gamehealth - 1
		Global.startpoints = Global.startpoints + 1
		$points/numbers.text = str(Global.startpoints)
		$health/Stats/Value.text = str(Global.gamehealth)
		$health/Stats/Change.text = str(Global.gamehealth - 10)
		$ResultHealth/Number.text = str(Global.gamehealth * 10)



func _on_Reset_pressed():
	Global.startpoints = 25
	Global.gamehealth = 10
	Global.gamestrength = 10
	Global.gameagility = 10
	Global.gameintellect = 10
	$points/numbers.text = str(Global.startpoints)
	$health/Stats/Value.text = str(Global.gamehealth)
	$straight/Stats/Value.text = str(Global.gamestrength)
	$agility/Stats/Value.text = str(Global.gameagility)
	$Magic/Stats/Value.text = str(Global.gameintellect)
	$health/Stats/Change.text = '0'
	$straight/Stats/Change.text = '0'
	$agility/Stats/Change.text = '0'
	$Magic/Stats/Change.text = '0'
	$ResultHealth/Number.text = str(Global.gamehealth * 10)
	$ResultStraight/Number.text = str(Global.gamestrength * 5)
	$ResultAgility/Number.text = str(Global.gameagility * 5)
	$ResultMagic/Number.text = str(Global.gameintellect * 5)


func _on_straight_minus_pressed():
	if Global.gamestrength != 0:
		Global.gamestrength = Global.gamestrength - 1
		Global.startpoints = Global.startpoints + 1
		$points/numbers.text = str(Global.startpoints)
		$straight/Stats/Value.text = str(Global.gamestrength)
		$straight/Stats/Change.text = str(Global.gamestrength - 10)
		$ResultStraight/Number.text = str(Global.gamestrength * 5)

func _on_straight_plus_pressed():
	if Global.startpoints != 0:
		Global.gamestrength = Global.gamestrength + 1
		Global.startpoints = Global.startpoints - 1
		$points/numbers.text = str(Global.startpoints)
		$straight/Stats/Value.text = str(Global.gamestrength)
		$straight/Stats/Change.text = str(Global.gamestrength - 10)
		$ResultStraight/Number.text = str(Global.gamestrength * 5)

func _on_agility_minus_pressed():

	if Global.gameagility != 0:
		Global.gameagility = Global.gameagility - 1
		Global.startpoints = Global.startpoints + 1
		$points/numbers.text = str(Global.startpoints)
		$agility/Stats/Value.text = str(Global.gameagility)
		$agility/Stats/Change.text = str(Global.gameagility - 10)
		$ResultAgility/Number.text = str(Global.gameagility * 5)

func _on_agility_plus_pressed():

	if Global.startpoints != 0:
		Global.gameagility = Global.gameagility + 1
		Global.startpoints = Global.startpoints - 1
		$points/numbers.text = str(Global.startpoints)
		$agility/Stats/Value.text = str(Global.gameagility)
		$agility/Stats/Change.text = str(Global.gameagility - 10)
		$ResultAgility/Number.text = str(Global.gameagility * 5)
	
func _on_magic_minus_pressed():
	if Global.gameintellect != 0:
		Global.gameintellect = Global.gameintellect - 1
		Global.startpoints = Global.startpoints + 1
		$points/numbers.text = str(Global.startpoints)
		$Magic/Stats/Value.text = str(Global.gameintellect)
		$Magic/Stats/Change.text = str(Global.gameintellect - 10)
		$ResultMagic/Number.text = str(Global.gameintellect * 5)

func _on_magic_plus_pressed():
	if Global.startpoints != 0:
		Global.gameintellect = Global.gameintellect + 1
		Global.startpoints = Global.startpoints - 1
		$points/numbers.text = str(Global.startpoints)
		$Magic/Stats/Value.text = str(Global.gameintellect)
		$Magic/Stats/Change.text = str(Global.gameintellect - 10)
		$ResultMagic/Number.text = str(Global.gameintellect * 5)




