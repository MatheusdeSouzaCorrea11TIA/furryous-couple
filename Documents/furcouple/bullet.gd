extends Node2D
class_name bulletNode

var speed = 5.0
var dir : float
var damageValue : int
var spread : float
var rotDir : float
var playerParent : CharacterBody2D

func _ready():
	global_rotation = dir
	rotDir = dir + randf_range(deg_to_rad(-spread),deg_to_rad(spread))

func _process(_delta):
	global_position += Vector2(speed,0).rotated(dir)
	global_rotation = rotDir

func _on_bullet_body_entered(body):
	if body != self and body != gunNode and body != lyan:
		delete()

func _on_area_2d_area_entered(area):
	#Ignorar
	if area.name != "Bullet" and area.name != "Equip" and area.name !="Player":
		delete()
	#Inimigo
	if area.name == "Enemy":
		damage(area,damageValue)

func delete():
	$Sprite2D.hide()
	$Bullet.queue_free()
	speed = 0
	$Particles.emitting = true
	await get_tree().create_timer($Particles.lifetime).timeout
	queue_free()

func damage(area,value : int):
	area.get_parent().life -= value
