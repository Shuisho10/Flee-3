extends Sprite2D

var lane: int = 0
@export var lane_size: int = 2
@export var lane_distance :Vector2 = Vector2(1,100)
@export var current_scene :Scroller
var buffer_jump: bool = true
var is_grounded: bool = true
@onready var timer: Timer = $Timer

#Move player to lane
func _process(_delta):
	position.y = lane * lane_distance.y

func jump():
	if buffer_jump and is_grounded:
		print("jumped")
		is_grounded = false
		#cancel at 3 steps
		timer.start(1)
		timer.timeout.connect(reset_jump)

func _input(e):
	if Input.is_action_just_pressed("button_down"):
		move_up()
	if Input.is_action_just_pressed("button_up"):
		move_down()
	if Input.is_action_just_pressed("button_jump"):
		if is_grounded and not buffer_jump:
			print("in buffer")
			buffer_jump = true



func reset_jump():
	print("reset")
	is_grounded = true
	buffer_jump = false

func is_jumping():
	return not is_grounded

func move_up():
	if lane_size > lane:
		lane += 1

func move_down():
	if -lane_size < lane:
		lane -= 1

func _on_escena_next_obstacle():
	jump()
