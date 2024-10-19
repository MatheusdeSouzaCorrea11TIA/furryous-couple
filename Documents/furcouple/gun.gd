extends Node2D
class_name gunNode

@export var shotEffect : AnimatedSprite2D
@export var ShootPos : Marker2D
@export var shotCol : Timer
var bullet = preload("res://bullet.tscn")
var bullets
var equipped = false
var canShoot = true

func _input(event):
	if event.is_action_pressed("dropgun") and equipped == true:
		equipped = false
		$Equip/CollisionShape2D.disabled = true
		await get_tree().create_timer(1.5).timeout
		$Equip/CollisionShape2D.disabled = false
		
func _ready():
	pass

func _process(_delta):
	if equipped == true:
		z_index = -1
		global_rotation = get_parent().global_rotation
		global_position = get_parent().global_position
		if get_parent().global_position.x < get_global_mouse_position().x: 
			$gunSprite.scale.y = 1
		if get_parent().global_position.x > get_global_mouse_position().x: 
			$gunSprite.scale.y = -1
		var shootButton = Input.is_action_pressed("shoot")
		
		##FAZER A ARMA ATIRAR OU COM O TECLADO OU COM O CONTROLE
		
		if shootButton and canShoot == true:
			shoot()
	if equipped == false:
		z_index = 0
		self.reparent.call_deferred(get_tree().get_root().get_child(1))

func shoot():
	shotCol.start()
	shotEffect.play()
	canShoot = false
	get_parent().playAnim()
	var bulInst = bullet.instantiate()
	bulInst.global_position = ShootPos.global_position
	bulInst.dir = get_parent().rotation
	bulInst.damageValue = 1
	get_tree().get_root().get_child(0).add_child(bulInst)
	

func _on_equip_area_entered(area):
	if area.name == "Player" and equipped == false:
		equipGun(area)

func equipGun(player):
	equipped = true
	self.reparent.call_deferred(player.get_parent().get_node("GunHands"))
	
	
func _on_shot_col_timeout():
	canShoot = true
