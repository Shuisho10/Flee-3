extends Node2D
class_name RandomChunk

@export var chunk_length :int = 5
var current_scene: Scroller
var entered_screen := false

@export_range(0.,1.) var frequency : float = 0.2

func setup(scene: Scroller):
	current_scene=scene
	var vis_notif : VisibleOnScreenNotifier2D = %VisibilityNotifier
	vis_notif.scale = Vector2(chunk_length,5)*2+Vector2(1,1)
	vis_notif.position.x = chunk_length * scene.obs_size.x/2
	var obs_var :Node2D = %Obstacles
	
	if obs_var.get_child_count()>0:
		var guaranteed_lane:int = scene.rng.randi_range(0,current_scene.lane_size*2)
		for j in range(current_scene.lane_size*2+1):
			for i in range(chunk_length-1):
				if scene.rng.randf() < frequency and not (j==guaranteed_lane and fmod(i,2)==0):
					_spawn(scene.rng.randi_range(0,obs_var.get_child_count()-1),Vector2(i,j))
	

func _spawn(child_index,grid_pos):
	var obs_var :Node2D = %Obstacles
	var new_obs :Node2D= obs_var.get_child(child_index).duplicate()
	new_obs.position = Vector2(current_scene.obs_size.x*grid_pos.x, current_scene.obs_size.y*(grid_pos.y-current_scene.lane_size))
	add_child(new_obs)

func _process(delta):
	position.x-=delta*current_scene.speed

func _on_visibility_notifier_screen_entered():
	entered_screen = true

func _on_visibility_notifier_screen_exited():
	if entered_screen:
		queue_free()
