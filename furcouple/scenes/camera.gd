extends Camera2D

@onready var players = get_tree().get_nodes_in_group("Player")
var zoomin = 1
var zoommax = 0.7

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position = lerp(global_position,lerp(players[0].global_position,players[1].global_position,0.5),0.3)
	var screensize = get_viewport_rect().size
	var distance = abs(players[0].global_position - players[1].global_position)
	var outputX = remap(distance.x, screensize.x * 0.9, screensize.x * 1.3, zoomin, zoommax)
	var outputY = remap(distance.y, screensize.y * 0.9, screensize.y * 1.3, zoomin, zoommax)
	
	#Calculo pra aumentar a camera
	if distance.x >= screensize.x * 0.9:
		zoom.x = outputX
		zoom.y = outputX
	if distance.y >= screensize.y * 0.9:
		zoom.x = outputY
		zoom.y = outputY
	#Limite de zoom
	if zoom.x < zoommax:
		zoom.x = zoommax
		zoom.y = zoommax
	else:
		if distance.x >= screensize.x * 0.9:
			zoom.x = outputX
			zoom.y = outputX
		if distance.y >= screensize.y * 0.9:
			zoom.x = outputY
			zoom.y = outputY
