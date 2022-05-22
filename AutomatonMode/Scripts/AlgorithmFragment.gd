#Тип-контейнер для данных о строчке алгоритма
extends Object

class_name AlgorithmFragment

enum CONDITION_DIRECTIONS {
	Point,
	AllWays,
	Right,
	Down,
	Left,
	Up,
	UpRight,
	DownRight,
	DownLeft,
	UpLeft,
	RightLeft,
	UpDown,
	UpDownRight,
	UpDownLeft,
	UpRightLeft,
	DownRightLeft
}

enum SEE_CONDITIONS {
	See,
	NotSee,
	NotMatter
}

var condition_state: int
var condition_directions
var see_condition
var see_radius: int
var to_state: int
var to_direction: Vector2

#Конструктор
func _init(condition_state_: int, see_condition_, condition_directions_, to_state_: int, to_direction_: Vector2, see_radius_: int):
	condition_state = condition_state_
	condition_directions = condition_directions_
	to_state = to_state_
	to_direction = to_direction_
	see_condition = see_condition_
	see_radius = see_radius_

func _to_string() -> String:
	return "[{0}; {1}; {2}; {3}]".format({"0": condition_state, "1": CONDITION_DIRECTIONS[condition_directions], "3": to_direction, "2": to_state})
