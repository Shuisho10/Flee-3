extends Node2D

func _process(delta):
	position.x+=delta*1000.

func _on_area_2d_area_entered(area):
	area.get_parent().queue_free()
	queue_free()
