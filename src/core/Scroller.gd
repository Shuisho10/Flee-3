class_name Scroller
extends Node2D
signal next_obstacle

@export var section_score: Array[float]
@export var chunk_pools: Array[Node2D]
@export var speed: float = 100
@export var end_score: float = 150


var section: int = 0
var running: bool = true
var scrolled: float = 0 
var lane_size:int = 2
var obs_count:int = 0
var points:int = 0
var obs_size: Vector2 = Vector2(128,128)
var chunk_spawn_distance :int = 706
var _wait: int = 0
var _point_timer: Timer
var rng: RandomNumberGenerator

func _init():
	rng = RandomNumberGenerator.new()
	Engine.max_fps = 120
	_point_timer = Timer.new()
	add_child(_point_timer)
	_point_timer.wait_time = 1.0
	_point_timer.autostart = true
	_point_timer.timeout.connect(score_by_sec)

func _process(delta: float):
	if section_score.size()>section and section_score[section]<points:
		section+=1
	
	if running:
		scrolled += delta*speed
		if obs_count<floor((scrolled)/obs_size.x):
			obs_count = int((scrolled)/obs_size.x)
			emit_signal("next_obstacle")
			_spawn()
			_wait-=1

func _spawn():
	if _wait<0:
		var randomint: int = rng.randi_range(0,chunk_pools[section].get_children().size()-1)
		var new_chunk :Node2D = chunk_pools[section].get_children()[randomint].duplicate()
		add_child(new_chunk)
		new_chunk.position = Vector2(chunk_spawn_distance-fmod(scrolled,128),0)
		new_chunk.setup(self)
		_wait = new_chunk.chunk_length

func score_by_sec():
	points += 1
	print(points)

func time_per_obsticle():
	return obs_size.x/speed

func game_over():
	_point_timer.stop()
	running = false
	speed = 0
