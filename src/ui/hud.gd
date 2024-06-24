extends CanvasLayer

@export var current_scene: Scroller


func _process(_delta):
	if current_scene:
		%ProgressBar.value = float(current_scene.points)/current_scene.end_score
		%ScoreLabel.text = "Puntuación: " + str(current_scene.points)
