extends Sprite2D
signal player_hit

@export var current_scene : Scroller
@onready var _anim_player: AnimationPlayer = %AnimationPlayer
@onready var _anim_jump: Animation = _anim_player.get_animation("jump")

var lane: int = 0
var locked_movement: bool = false
var jumping: bool = false
var side_jump: bool = false

func _process(delta: float):
	if current_scene.running:
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
	%Hitbox.monitoring = true
	if %Hitbox.get_overlapping_areas():
		game_over()

func _input(_e):
	if Input.is_action_just_pressed("button_reset"):
		get_tree().reload_current_scene()

func game_over():
	current_scene.game_over()
	_anim_player.stop()

func _on_area_2d_area_shape_entered(_area_rid, _area, _area_shape_index, _local_shape_index):
	if not jumping:
		game_over()
