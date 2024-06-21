class_name Scroller
extends Node2D
signal next_obstacle

var scrolled: float = 0 
@export var speed: float = 100
var lane_size:int = 2
var obs_count:int = 0
var obs_size: Vector2 = Vector2(128,128)
var chunk_spawn_distance = 650
var rng: RandomNumberGenerator
var wait: int =0
@onready var example := preload("res://res/scenes/core/random_chunk.tscn")

func _init():
	rng = RandomNumberGenerator.new()
	Engine.max_fps = 120

func _process(delta):
	scrolled += delta*speed
	if obs_count<floor((scrolled)/obs_size.x):
		obs_count = int((scrolled)/obs_size.x)
		emit_signal("next_obstacle")
		print("signal emitted [", obs_count,"]")
		_spawn()

func _spawn():
	wait=int(fmod(wait+1,5))
	if wait==0:
		var a := example.instantiate()
		a.position = Vector2(chunk_spawn_distance,0)
		a.setup(self)
		add_child(a)
	
func time_per_obsticle():
	return obs_size.x/speed

#spawn at next obstacle/pattern based generation/obstacle culling
