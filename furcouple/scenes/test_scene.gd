extends Node2D

@export var colorRect : ColorRect
@export var lyanLabel : Label
@export var lynxLabel : Label
@onready var enemySpawn = [$EnemySpawn/Spawn1, $EnemySpawn/Spawn2, $EnemySpawn/Spawn3, $EnemySpawn/Spawn4]
var lyanAssign = false
var lynxAssign = false
var enemy = preload("res://enemy.tscn")
var toggled = false
var enemyCount = [null]

func _ready():
	pass
 
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("restart") and get_tree():
		get_tree().reload_current_scene()
	
	if colorRect != null:
		if lyanAssign == true:
			if event is InputEventKey:
				$Lyan.inputType = 0
				lyanAssign = false
				lyanLabel.text = "0"
			if event is InputEventJoypadButton:
				$Lyan.inputType = 1
				lyanAssign = false
				lyanLabel.text = "1"
		
	if colorRect != null:
		if lynxAssign == true:
			if event is InputEventKey:
				$Lynx.inputType = 0
				lynxAssign = false
				lynxLabel.text = "0"
			if event is InputEventJoypadButton:
				$Lynx.inputType = 1
				lynxAssign = false
				lynxLabel.text = "1"
				
	if toggled == true and $enemySpawn.is_stopped():
		var enInst = enemy.instantiate()
		var randIndex = enemySpawn[randi_range(0,3)]
		#enInst.global_position = Vector2(randi_range(8,304),randi_range(8,168))
		enInst.global_position = randIndex.global_position
		get_tree().get_root().get_child(1).add_child(enInst)
		$enemySpawn.start()

func _on_button_pressed():
	colorRect.queue_free()

func _on_lyan_pressed():
	lyanAssign = true
	lynxAssign = false
	lyanLabel.text = "assign"

func _on_lynx_pressed():
	lynxAssign = true
	lyanAssign = false
	lynxLabel.text = "assign"
	
func _on_spawn_enemies_toggled(toggled_on):
	if toggled_on:
		toggled = true
