class_name Scroller
extends Node2D
signal next_obstacle

var scrolled: float = 0 
var speed: float = 100
var obstacle_distance: float = 128
var obstacle_count:int = 0

func _process(delta):
	scrolled += delta
	if obstacle_count<floor((scrolled*speed)/obstacle_distance):
		obstacle_count = (scrolled*speed)/obstacle_distance
		emit_signal("next_obstacle")
		print("signal emitted [", obstacle_count,"]")
	position.x = -scrolled*speed

#spawn at next obstacle/pattern based generation/obstacle culling
