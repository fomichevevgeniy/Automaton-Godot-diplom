extends TileMap

signal bitmask_updated
signal bitmask_updating_progressed(precentage)

export var threads_count: int

func update_bitmask_region_async(start: Vector2, end: Vector2) -> void:
	var builders = []
	var offset = int((end.x-start.x)/threads_count) + 1
	var ready = false
	for i in threads_count:
		pass
		var thread = Thread.new()
		var builder = Builder.new(Vector2(start.x+i*offset,start.y), Vector2(start.x+i*offset+offset,end.y))
		builder.add_thread(thread)
		builders.append(builder)
		thread.start(self, "_thread_update", builder)
	
	while not ready:
		ready = true
		var precentage = 0
		for i in builders:
			precentage += i.ready_part
			if not i.ready:
				ready = false
				break
		emit_signal("bitmask_updating_progressed", precentage)
		yield(get_tree().create_timer(0.2),"timeout")
	emit_signal("bitmask_updated")
	

func _thread_update(user_data):
	var builder = user_data as Builder
	var lenght = builder.end_point.x - builder.start_point.x
	for i in lenght:
		update_bitmask_region(Vector2(builder.start_point.x+i,builder.start_point.y),Vector2(builder.start_point.x+i+1,builder.end_point.y))
		yield(get_tree().create_timer(0.1),"timeout")
		builder.ready_part = i*100/lenght
	builder.ready = true

class Builder:
	var ready: bool = false
	var start_point: Vector2
	var end_point: Vector2
	var thread: Thread
	var ready_part: float = 0
	
	func add_thread(thread_: Thread):
		thread = thread_
	
	func _init(start: Vector2, end: Vector2):
		self.start_point = start
		self.end_point = end
