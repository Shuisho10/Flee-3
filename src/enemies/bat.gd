extends Enemy

var _anim_loop: float = 0

func _process(delta):
	if is_running:
		position.x-=delta*current_scene.speed*1.5
	
	if current_scene:
		_anim_loop+=delta*7
		frame = int(fmod(_anim_loop,2))
	
