extends Node2D
class_name PregenChunk

@export var _can_flip_x := true
@export var _can_flip_y := true
@export var chunk_length := 1
var current_scene: Scroller
var entered_screen := false

func setup(scene: Scroller):
	current_scene=scene
	var vis_notif : VisibleOnScreenNotifier2D = %VisibilityNotifier
	vis_notif.scale = Vector2(chunk_length,current_scene.lane_size*2+1)*2+Vector2(1,1)
	vis_notif.position.x = chunk_length * scene.obs_size.x/2
	if _can_flip_x and current_scene.rng.randi_range(0,1) == 1:
		for child in get_children():
			if child!=%VisibilityNotifier:
				child.position.x*=-1
	if _can_flip_y and current_scene.rng.randi_range(0,1) == 1:
		for child in get_children():
			if child!=%VisibilityNotifier:
				child.position.y*=-1
		

func _process(delta: float):
	if current_scene:
		position.x-=delta*current_scene.speed

func _on_visibility_notifier_screen_entered():
	entered_screen = true


func _on_visibility_notifier_screen_exited():
	if entered_screen:
		queue_free()
