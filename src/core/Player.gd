extends Sprite2D

@export var current_scene : Scroller

var lane: int = 0
@onready var anim :AnimationPlayer= %AnimationPlayer

#Move player to lane
func _process(delta):
	position.y = lerpf(position.y,lane * current_scene.obs_size.y, delta *20)
	if Input.is_action_pressed("button_jump") and anim.current_animation=="":
		jump()


func _input(_e):
	if Input.is_action_just_pressed("button_down"):
		move_up()
	if Input.is_action_just_pressed("button_up"):
		move_down()
	
	

func jump():
	anim.play("jump",1,2.0)
	

func move_up():
	if current_scene.lane_size > lane:
		lane += 1

func move_down():
	if -current_scene.lane_size < lane:
		lane -= 1
