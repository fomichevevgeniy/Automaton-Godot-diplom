#Скрипт UI отображения строчки алгоритма

extends Control

class_name AlgorithmPart

#Таблица для перевода 

const TO_DIRECTIONS = {
	0: Vector2.ZERO,
	1: Vector2.RIGHT,
	2: Vector2.DOWN,
	3: Vector2.LEFT,
	4: Vector2.UP
}

var condition_state: int
var condition_direction
var see_condition
var see_radius: int
var to_state: int
var to_direction: Vector2

#Установка условия по свободным направлениям
func _on_ConditionDirectionChoose_item_selected(id):
	condition_direction = AlgorithmFragment.CONDITION_DIRECTIONS.keys()[id]

#Установка направления движения
func _on_ToDirectionChoose_item_selected(id):
	to_direction = TO_DIRECTIONS[id]


#Установка условия по состоянию
func _on_ConditionState_text_entered(new_text):
	condition_state = int(new_text)

#Установка состояния после перехода
func _on_ToState_text_entered(new_text):
	to_state = int(new_text)

#Получение экземпляра типа-контейнера для данных о строке алгоритма
func get_fragment() -> AlgorithmFragment:
	return AlgorithmFragment.new(condition_state, see_condition, condition_direction, to_state, to_direction, see_radius)

func load_fragment(fragment: AlgorithmFragment):
	condition_state = fragment.condition_state
	$ColorRect/ConditionState.text = str(condition_state)
	condition_direction = fragment.condition_directions
	$ColorRect/ConditionDirectionChoose.set_icon(fragment.CONDITION_DIRECTIONS[condition_direction])
	see_condition = fragment.see_condition
	$ColorRect/SeeCondition.set_icon(see_condition)
	to_direction = fragment.to_direction
	$ColorRect/ToDirectionChoose.set_icon(TO_DIRECTIONS.values().find(fragment.to_direction))
	to_state = fragment.to_state
	$ColorRect/ToState.text = str(to_state)
	see_radius = fragment.see_radius
	$ColorRect/SeeRadius.text = str(see_radius)

#Восстановление внешнего облика UI представления строки алгоритма из строки(данных типа String)
func d_parse(data: String) -> void:
	var splited_data = data.replace("[","").replace("]","").split("; ")
	condition_state = int(splited_data[0])
	$ColorRect/ConditionState.text = str(condition_state)
	condition_direction = AlgorithmFragment.CONDITION_DIRECTIONS.keys()[int(splited_data[1])]
	$ColorRect/ConditionDirectionChoose.texture_normal = $ColorRect/ConditionDirectionChoose/ConditionDirection.get_item_icon(int(splited_data[1]))
	to_state = int(splited_data[2])
	$ColorRect/ToState.text = str(to_state)
	
	var unparsed_vector = splited_data[3].replace("(","").replace(")","").split(", ")
	var vector: Vector2 = Vector2(float(unparsed_vector[0]), float(unparsed_vector[1]))
	
	to_direction = vector
	
	$ColorRect/ToDirectionChoose.texture_normal = $ColorRect/ToDirectionChoose/ToDirection.get_item_icon(TO_DIRECTIONS.values().find(to_direction))

#Удаление строки
func _on_Delete_pressed():
	queue_free()


func _on_SeeCondition_item_selected(id):
	match id:
		0:
			see_condition = AlgorithmFragment.SEE_CONDITIONS.See
		1:
			see_condition = AlgorithmFragment.SEE_CONDITIONS.NotSee
		2:
			see_condition = AlgorithmFragment.SEE_CONDITIONS.NotMatter


func _on_SeeRadius_text_entered(new_text):
	see_radius = int(new_text)
