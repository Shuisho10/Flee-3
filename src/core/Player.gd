extends Sprite2D
signal player_hit

#Relations
@export var current_scene : Scroller
@onready var _anim_player: AnimationPlayer = %AnimationPlayer
@onready var _anim_jump: Animation = _anim_player.get_animation("jump")
var _proyectile_scene = preload("res://res/scenes/core/proyectile.tscn")

#Movement
var lane: int = 0
var locked_movement: bool = false
var jumping: bool = false
var side_jump: bool = false

#Powerups
var invencible:float = 0.
var proyectiles:=0

func _process(delta: float):
	
	if invencible>0:
		invencible-=delta
		if invencible<3.:
			%ShieldSprite.visible = sin(invencible*10.)<0
		else:
			%ShieldSprite.visible = true
	else:
		%ShieldSprite.visible = false
	
	
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
	if %Hitbox.get_overlapping_areas():
		game_over()

func _input(_e):
	if Input.is_action_just_pressed("button_reset"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("button_shoot"):
		if proyectiles>0:
			_shoot_proyectile()

func game_over():
	current_scene.game_over()
	_anim_player.stop()

func _shoot_proyectile():
	if not %ShotgunAnimation.is_playing():
		proyectiles-=1
		var p:=_proyectile_scene.instantiate()
		get_parent().add_child(p)
		p.global_position=global_position+Vector2(64,0)
		
		%ShotgunAnimation.play("shoot",1)
		await %ShotgunAnimation.animation_finished
		%ShotgunSprite.visible = proyectiles>0

func on_power_up():
	var powerup:=current_scene.rng.randi_range(0,1)
	match(powerup):
		0:
			proyectiles=5
		1:
			print("shield")
			invencible=7.
		_:
			print("wtf")




func _on_area_2d_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.get_collision_layer_value(4):
		area.get_parent().visible = false
		area.set_deferred("monitorable",false)
		on_power_up()
	
	if invencible<=0:
		if area.get_collision_layer_value(3):
			game_over()
		if area.get_collision_layer_value(2):
			if jumping:
				current_scene.points+=1
			else:
				game_over()
