extends Node2D
class_name PregenChunk

@export var _can_flip_x := true
@export var _can_flip_y := true
@export var chunk_size := Vector2i(1,1)
var current_scene: Scroller
var entered_screen := false

func setup(scene: Scroller):
	current_scene=scene
	var vis_notif : VisibleOnScreenNotifier2D = %VisibilityNotifier
	vis_notif.scale = Vector2(chunk_size)*2+Vector2(1,1)
	vis_notif.position.x = chunk_size.x * scene.obs_size.x/2
	if _can_flip_x and current_scene.rng.randi_range(0,1) == 1:
		for child in %Obstacles.get_children():
			child.position.x=-child.position.x
			print("flipped x")
	if _can_flip_y and current_scene.rng.randi_range(0,1) == 1:
		for child in %Obstacles.get_children():
			child.position.y=-child.position.y
			print("flipped y")
		

func _process(delta: float):
	if current_scene:
		position.x-=delta*current_scene.speed

func _on_visibility_notifier_screen_entered():
	entered_screen = true


func _on_visibility_notifier_screen_exited():
	if entered_screen:
		queue_free()
