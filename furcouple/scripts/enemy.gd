extends CharacterBody2D

@export var randSpeed : Timer
@export var anim : AnimationPlayer
@export var attackTime : Timer
@export var attackArea : Area2D
var randomSpd = speed
var speed = 50.0
var accel = 10
var life = 10
var players
var attacking = false

func _ready():
	players = get_tree().get_nodes_in_group("Player")

func _process(_delta):
	
	var playerFollow
	var lyanDistance = position.distance_to(players[0].position)
	var lynxDistance = position.distance_to(players[1].position)
	var targetPos : Vector2
	
	if lyanDistance < lynxDistance:
		playerFollow = players[0]
		targetPos = (players[0].position - position).normalized()
	if lynxDistance < lyanDistance:
		playerFollow = players[1]
		targetPos = (players[1].position - position).normalized()
	if playerFollow.global_position.x > global_position.x:
		$Sprite.flip_h = false
		attackArea.get_node("Slash").flip_h = true
	if playerFollow.global_position.x < global_position.x:
		$Sprite.flip_h = true
		attackArea.get_node("Slash").flip_h = true
	
	if !attackTime.is_stopped():
		if !anim.is_playing(): anim.play("Run")
		attackArea.look_at(playerFollow.global_position)
		velocity.x = move_toward(velocity.x,targetPos.x * speed,accel)
		velocity.y = move_toward(velocity.y,targetPos.y * speed,accel)
	if attackTime.is_stopped():
		attack()
	
	if life <= 0:
		queue_free()
	move_and_slide()

func attack():
	anim.play("attack")
	attackTime.start()
	
func _on_enemy_area_entered(area):
	if area.name == "Player":
		velocity = Vector2.ZERO

func _on_distance_area_entered(area):
	attackTime.start()
