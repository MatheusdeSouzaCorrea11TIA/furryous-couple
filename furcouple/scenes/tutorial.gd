extends Node2D


func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass
	
func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
