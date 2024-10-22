extends StaticBody2D

@export var anim : AnimationPlayer

func _ready():
	pass

func _process(_delta):
	if !anim.is_playing():
		anim.play("Idle")

func takeHit(hit):
	if hit.global_position > self.global_position: 
		if !anim.is_playing() or anim.current_animation == "Idle":
			anim.play("hitL")
	if hit.global_position < self.global_position :
		if !anim.is_playing() or anim.current_animation == "Idle":
			anim.play("hitR")

func _on_dummy_area_area_entered(area):
	if area.name == "Bullet":
		takeHit(area.get_parent())
