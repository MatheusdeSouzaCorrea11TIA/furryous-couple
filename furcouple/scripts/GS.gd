extends Node

var paw = preload("res://sprites/pawCursor.png")

func _ready():
	Input.set_custom_mouse_cursor(paw)

func _process(_delta):
	pass
	
func equipToPlayer(player):
	pass
