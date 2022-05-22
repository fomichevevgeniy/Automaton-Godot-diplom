extends RigidBody2D

class_name Room_

const MOBS_PER_TILE = 64

var safe: bool = false
var activated: bool = false
var size
var mob_count


func make_room(_pos, _size):
	position = _pos
	size = _size
	var s = RectangleShape2D.new()
	s.custom_solver_bias = 0.75
	s.extents = size
	$CollisionShape2D.shape = s
	$Area2D/CollisionShape2D.shape = s
	mob_count = round((size.x/64) * (size.y/64) / MOBS_PER_TILE)+1


func _on_Area2D_body_entered(body: Character):
	if body != null:
		_activate()

func _activate():
	if activated or safe: return
	activated = true
	$Area2D/CollisionShape2D.set_deferred("disabled", !activated)
	for i in mob_count:
		Thread.new().start(self, "_spawn_mob")
		yield(get_tree().create_timer(0.1),"timeout")
		

func _spawn_mob(data):
	var mob = Global.get_mob()
	get_tree().current_scene.get_node("Mobs").add_child(mob)
	mob.position = _get_point_in()

func _get_point_in() -> Vector2:
	var result = position + Vector2.ONE
	result.x += Global.random.randi_range(-size.x/2,size.x/2)
	result.y += Global.random.randi_range(-size.y/2,size.y/2)
	return result
