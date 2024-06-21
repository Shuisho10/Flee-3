class_name Scroller
extends Node2D
signal next_obstacle

var scrolled: float = 0 
var speed: float = 100
var lane_size:int = 2
var obs_count:int = 0
var obs_size: Vector2 = Vector2(128,128)
@export var example: Texture2D

func _process(delta):
	scrolled += delta
	if obs_count<floor((scrolled*speed)/obs_size.x):
		obs_count = int((scrolled*speed)/obs_size.x)
		emit_signal("next_obstacle")
		print("signal emitted [", obs_count,"]")
		_spawn()
	position.x = -scrolled*speed

func _spawn():
	var sprite2d := Sprite2D.new() # Create a new Sprite2D.
	sprite2d.texture = example
	sprite2d.global_position = Vector2(12+obs_size.x*obs_count,0)
	add_child(sprite2d)

func time_per_obsticle():
	return obs_size.x/speed

#spawn at next obstacle/pattern based generation/obstacle culling
