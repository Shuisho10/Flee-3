extends Sprite2D

@export var current_scene : Scroller

var lane: int = 0
var locked_movement: bool = false
var jumping: bool = false
var side_jump: bool = false
@onready var _anim_player: AnimationPlayer = %AnimationPlayer
@onready var _anim_jump: Animation = _anim_player.get_animation("jump")

#Move player to lane
func _process(delta: float):
	position.y = lerpf(position.y, lane * current_scene.obs_size.y, clampf(delta * current_scene.speed / 20,0,1))
	if Input.is_action_pressed("button_jump"):
		jump()
	else:
		_anim_jump.loop_mode = Animation.LOOP_NONE
	if not jumping or side_jump:
		if Input.is_action_just_pressed("button_down"):
			move_up()
			side_jump = false
		if Input.is_action_just_pressed("button_up"):
			move_down()
			side_jump = false


func jump():
	if not jumping:
		if _anim_player.current_animation == "":
			_anim_jump.loop_mode = Animation.LOOP_LINEAR
			_anim_player.play("jump",-1,1/(current_scene.time_per_obsticle()*2))
		side_jump = true
		jumping=true
	

func move_up():
	if current_scene.lane_size > lane:
		lane += 1
	

func move_down():
	if -current_scene.lane_size < lane:
		lane -= 1

func end_jump():
	jumping=false
