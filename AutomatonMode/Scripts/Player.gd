#Класс игрока
extends KinematicBody2D

class_name Player

signal move_finished
signal move_failed

#Список рейкастов в разные стороны. Расположены по часовой стрелке, с правого до верхнего
onready var rays = [$RayRight, $RayDown, $RayLeft, $RayUp]

export var vision_radius = 128
var is_process: bool = true
var seeing_status
var seeing_authomats: int = 0
var state: int
var algorithm_fragments: Array = []
var start_colliding_map: Array = []

#Запуск циклической корутины, в каждой итерации выбирается и воспроизводится подходящая строчка алгоритма
func load_algorithm(start_state: int, algorithm: Array) -> void:
	state = start_state
	algorithm_fragments = algorithm

func start_algorithm(start_state: int, algorithm: Array) -> void:
	state = start_state
	algorithm_fragments = algorithm
	while (is_process):
		do_part()
		yield(self, "move_finished")

func start_algorithm1() -> void:
	while (is_process):
		do_part()
		yield(self, "move_finished")

func _physics_process(delta):
	if Input.is_key_pressed(ord("8")):
		print(wich_collides())
	
#Выбор и воспроизведение одной строки алгоритма. Завершение работы игрока в случае невозможности выполнения ни одной из строк
func do_part() -> void:
	for i in algorithm_fragments:
		var part = i as AlgorithmFragment
		if (state != part.condition_state) or (not check_ways(part.condition_directions)):  
			continue
		if part.see_condition != 2:
			if (part.see_condition == 1 and check_see_status(part.see_radius)) or (part.see_condition == 0 and not check_see_status(part.see_radius)):
				continue
		
		state = part.to_state
		if not check_direction(part.to_direction): break
		$Tween.interpolate_property(self, "position", position, position+part.to_direction*64, 1.0)
		$Tween.start()
		yield($Tween, "tween_completed")
		emit_signal("move_finished")
		return
	emit_signal("move_failed")

#Проверяет условие строки алгоритма по свободным направлениям
func check_ways(condition_directions_) -> bool:
	var collides = wich_collides()
	if len(start_colliding_map) != 0:
		collides = []
		for i in start_colliding_map:
			collides.append(rays[i])
		start_colliding_map = []
	print(len(collides))
	for i in collides:
		print(i.name)
	match (AlgorithmFragment.CONDITION_DIRECTIONS[condition_directions_]):
		0:
			return (len(collides) == 4)
		1:
			return (len(collides) == 0)
		2:
			return ((len(collides) == 3) and not (rays[0] in collides))
		3:
			return ((len(collides) == 3) and not (rays[1] in collides))
		4:
			return ((len(collides) == 3) and not (rays[2] in collides))
		5:
			return ((len(collides) == 3) and not (rays[3] in collides))
		6:
			return ((len(collides) == 2) and (not rays[0] in collides) and (not rays[3] in collides))
		7:
			return ((len(collides) == 2) and (not rays[0] in collides) and (not rays[1] in collides))
		8:
			return ((len(collides) == 2) and (not rays[2] in collides) and (not rays[1] in collides))
		9:
			return ((len(collides) == 2) and (not rays[2] in collides) and (not rays[3] in collides))
		10:
			return ((len(collides) == 2) and (not rays[0] in collides) and (not rays[2] in collides))
		11:
			return ((len(collides) == 2) and (not rays[1] in collides) and (not rays[3] in collides))
		12:
			return ((len(collides) == 1) and (rays[2] in collides))
		13:
			return ((len(collides) == 1) and (rays[0] in collides))
		14:
			return ((len(collides) == 1) and (rays[1] in collides))
		15:
			return ((len(collides) == 1) and (rays[3] in collides))
		_:
			return false

#Проверка фактической возможности двинуться в ту сторону, в которую указано в строке алгоритма
func check_direction(direction_: Vector2) -> bool:
	var index: int
	var x = direction_.x
	var y = direction_.y
	#страшная строка, переводящая нормализованный вектор в индекс списка рейкастов rays
	index = ((1-x)*abs(x))+((2-y)*abs(y))
	return not rays[index].is_colliding()

#Возвращает список рейкастов, которые в данный момент с чем-то соприкасаются
func wich_collides() -> Array:
	var result = []
	for i in rays:
		print(i.name, i.is_colliding())
		if (i as RayCast2D).is_colliding():
			result.append(i)
	return result

#Остановка работы игрока 
func stop() -> void:
	is_process = false

func check_see_status(radius: int) -> bool:
	for i in AutomatManager.get_automats():
		if i == self: continue
		var path = (i.position - position)/64
		print("X:", abs(path.x))
		print("Radius: ", radius)
		print("Result: ", abs(path.x) < radius or abs(path.y) < radius)
		if abs(path.x) <= radius and abs(path.y) <= radius: return true
	return false


func _on_Area2D_body_entered(body):
	if body == self: return
	print("Куку")
	seeing_authomats += 1


func _on_Area2D_body_exited(body):
	if body == self: return
	seeing_authomats -= 1
