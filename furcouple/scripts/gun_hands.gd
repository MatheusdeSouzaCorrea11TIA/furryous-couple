extends Sprite2D

@export var player : CharacterBody2D
@export var playerPos : Marker2D
@export var anim : AnimationPlayer
var spread = 5

func _ready():
	pass

func _process(_delta):
	pass
	
func playAnim():
	global_position -= global_position.direction_to(get_global_mouse_position())
	global_rotation -= deg_to_rad(randf_range(-spread,spread))

func resetHand():
	self.reparent(playerPos)
	self.global_position = playerPos.global_position
