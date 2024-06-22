class_name Enemy
extends Sprite2D

var is_running:=false

func setup(scene:Scroller):
	reparent(scene)
	is_running=true
