extends Node2D

class_name ProjectTile

var attacker
var effects: Array

func set_direction(direction: Vector2) -> ProjectTile:
	rotation = direction.angle()
	return self

func set_attacker(attacker_) -> ProjectTile:
	attacker = attacker_
	return self

func set_effects(effects_: Array) -> ProjectTile:
	effects = effects_
	return self


func _on_Area2D_body_entered(body: Living) -> void:
	if not body in [null, attacker]:
		var result = body.take_attack(attacker)
		
		if effects == null or len(effects): return
		
		for i in effects:
			(i as AttackEffect).apply(result)
