extends Node2D
class_name gunNode

@export var shotEffect : AnimatedSprite2D
@export var ShootPos : Marker2D
@export var shotCol : Timer
@export var anim : AnimationPlayer
var Players = [lyan.new(),lynx.new()]
var bullet = preload("res://bullet.tscn")
var bullets
var equipped = false
var canShoot = true
var shootButton
var flipped = false
var parent = null

func _ready():
	pass

func _process(_delta):
	if equipped == true:
		anim.play("Equipped")
		z_index = 1
		global_rotation = get_parent().global_rotation
		global_position = get_parent().global_position
		if parent.inputType == 0:
			if get_parent().global_position.x < get_global_mouse_position().x:
				flipped = false
			if get_parent().global_position.x > get_global_mouse_position().x:
				flipped = true
			shootButton = Input.is_action_pressed("shoot")
		if parent.inputType == 1:
			if get_parent().global_position.x < parent.gamepadCursor.global_position.x:
				flipped = false
			if get_parent().global_position.x > parent.gamepadCursor.global_position.x:
				flipped = true
			shootButton = Input.is_action_pressed("g_shoot")
		
		if flipped == false:
			$gunSprite.scale.y = 1
		if flipped == true: 
			$gunSprite.scale.y = -1
		
		if shootButton and canShoot == true:
			shoot()
	if equipped == false:
		name = "Gun"
		anim.play("Floating")
		rotation = 0
		z_index = 0
		if parent != null: parent.gunEquipped = false
		parent = null
		self.reparent.call_deferred(get_tree().get_root().get_child(1))
		
func _input(event):
	for area in $Equip.get_overlapping_areas():
		if area.name == "Player" and equipped == false and area.get_parent().gunEquipped == false:
			$EquipSPR.show()
			if $EquipSPR.is_visible_in_tree():
				if area.get_parent().inputType == 0 and event.is_action_pressed("equip") and event is InputEventKey:
					equipGun(area)
				if area.get_parent().inputType == 1 and event is InputEventJoypadButton:
					if event.is_action_pressed("equip"):
						equipGun(area)
	if equipped == true and parent != null:
		if parent.inputType == 0 and event.is_action_pressed("dropgun") and event is InputEventKey:
			equipped = false
		if parent.inputType == 1 and event is InputEventJoypadButton:
			if event.is_action_pressed("dropgun"):
				equipped = false

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
	pass

func _on_equip_area_exited(area):
	$EquipSPR.hide()

func equipGun(player):
	equipped = true
	parent = player.get_parent()
	parent.gunEquipped = true
	name = parent.name + "Gun"
	self.reparent.call_deferred(player.get_parent().get_node("GunHands"))
	
func _on_shot_col_timeout():
	canShoot = true
