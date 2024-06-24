extends Enemy

var _anim_loop: float = 0
var original_position: float

func setup(scene:Scroller):
	super(scene)
	original_position = position.y
	

func _process(delta):
	if current_scene:
		_anim_loop+=delta*3
		frame = int(fmod(_anim_loop,2))
	if is_running:
		if position.x < 400:
			position= Vector2(position.x-delta*current_scene.speed*0.75,
							  lerpf(position.y,-original_position,delta*current_scene.speed/500))
		else:
			position.x = position.x-delta*current_scene.speed*0.75
