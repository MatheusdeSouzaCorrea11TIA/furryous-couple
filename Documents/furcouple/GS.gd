extends Node

var paw = preload("res://pawCursor.png")

func _ready():
	Input.set_custom_mouse_cursor(paw)

func _process(_delta):
	pass
