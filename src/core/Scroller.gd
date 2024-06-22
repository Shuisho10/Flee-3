class_name Scroller
extends Node2D
signal next_obstacle

var scrolled: float = 0 
@export var speed: float = 100
var lane_size:int = 2
var obs_count:int = 0
var obs_size: Vector2 = Vector2(128,128)
var chunk_spawn_distance = 650
@export var chunk_pool: Array[Node2D]
var rng: RandomNumberGenerator
var wait: int =0

func _init():
	rng = RandomNumberGenerator.new()
	Engine.max_fps = 120

func _process(delta: float):
	scrolled += delta*speed
	if obs_count<floor((scrolled)/obs_size.x):
		obs_count = int((scrolled)/obs_size.x)
		emit_signal("next_obstacle")
		_spawn()
		wait-=1

func _spawn():
	if wait<0:
		var randomint: int = rng.randi_range(0,chunk_pool.size()-1)
		var new_chunk :Node2D = chunk_pool[randomint].duplicate()
		new_chunk.setup(self)
		add_child(new_chunk)
		new_chunk.position = Vector2(chunk_spawn_distance,0)
		wait = new_chunk.chunk_length
	
func time_per_obsticle():
	return obs_size.x/speed

#spawn at next obstacle/pattern based generation/obstacle culling
