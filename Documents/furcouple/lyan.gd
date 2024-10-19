extends CharacterBody2D
class_name lyan

const dashForce = 200.0
var speed = 90.0
var accel = 12
var friction = 12
@export var anim : AnimationPlayer
@export var gunAnim : AnimationPlayer
@export var body : Sprite2D
@export var hands : Sprite2D
@export var gunHands : Sprite2D

var playerNumber = 0
var canDash = true
@export var dashCol : Timer
@export var dashLenghtTimer : Timer
@export var dashLenght = 0.2

func _ready():
	anim.play("Idle")
	gunHands.hide()

func _physics_process(_delta):
	#Move Event
	var direction = Input.get_vector("d_left", "d_right","d_up","d_down")
	if direction:
		velocity.x = move_toward(velocity.x, speed * direction.x, accel)
		velocity.y = move_toward(velocity.y, speed * direction.y, accel)
		anim.play("Run")
	else:
		anim.play("Idle")
		velocity.x = move_toward(velocity.x, 0, friction)
		velocity.y = move_toward(velocity.y, 0, friction)
		
	#Dash Event
	if Input.is_action_just_pressed("dash") and canDash == true:
		dash()
	if !dashLenghtTimer.is_stopped(): 
		velocity = direction.normalized() * dashForce
	
	#Flip SPR
	var mousePos = get_global_mouse_position()
	if mousePos > self.global_position: 
		body.flip_h = false
		gunHands.flip_v = false
		hands.flip_h = false
	else: 
		body.flip_h = true
		gunHands.flip_v = true
		hands.flip_h = true
	
	#GunHands Show
	if gunHands.get_child_count() == 1:
		resetHand()
		gunHands.hide()
		hands.show()
	elif gunHands.get_child_count() > 1:
		gunHands.reparent(get_tree().get_root().get_child(1))
		gunHands.show()
		hands.hide()
		
	$Body.scale = lerp($Body.scale,Vector2.ONE,0.1)
	var dirMouse = get_global_mouse_position() - gunHands.global_position
	var angle = dirMouse.angle()
	gunHands.global_position.x = move_toward(gunHands.global_position.x,$GunHandsPos.global_position.x,accel-3)
	gunHands.global_position.y = move_toward(gunHands.global_position.y,$GunHandsPos.global_position.y,accel-3)
	gunHands.global_rotation = lerp_angle(gunHands.global_rotation,angle,0.25)
	move_and_slide()

func dash():
	$Body.scale = Vector2(1.75,0.7)
	canDash = false
	dashLenghtTimer.start()
	dashCol.start()

func _on_dash_col_timeout():
	canDash = true
	
func resetHand():
	gunHands.reparent(self)
	gunHands.global_position = self.global_position
