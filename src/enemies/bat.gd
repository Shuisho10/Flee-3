extends Enemy

func _process(delta):
	if is_running:
		position.x-=delta*1500
