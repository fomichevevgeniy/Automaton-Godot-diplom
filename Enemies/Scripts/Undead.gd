extends Enemy

func _AI(target: Living):
	if target == null: return
	if position.distance_to(target.position) >= 128:
		velocity = position.direction_to(target.position) * speed
		return
	velocity = Vector2.ZERO
	$Attacker.attack(position.direction_to(target.position))
