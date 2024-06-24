extends Node2D

@export var current_scene: Scroller
@export var tile: Texture2D

func _ready():
	var sprite: Sprite2D
	for i in range(-current_scene.lane_size,current_scene.lane_size+1):
		sprite = Sprite2D.new()
		add_child(sprite)
		sprite.texture = tile
		sprite.scale = Vector2(4,4)
		sprite.position = Vector2(fmod(i,2)*128,i*128)

func _process(_delta):
	get_parent().motion_offset=Vector2(-current_scene.scrolled,0)
