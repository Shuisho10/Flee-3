class_name Enemy
extends Sprite2D

var current_scene: Scroller
var is_running:=false

func setup(scene:Scroller):
	reparent(scene)
	current_scene=scene
	is_running=true
