extends "res://scripts/ammunitions/ammo.gd"

var speed = 0
var direction = Vector2()

func _fixed_process(delta):
	var velocity = direction * speed * delta
	move(velocity)
	
	if is_out_of_bound():
		queue_free()
	elif is_colliding():
		var collider = get_collider()
		if collider.has_method("take_damages"):
			collider.take_damages(1)
		queue_free()

func set_speed(sp):
	speed = sp

func set_direction(dir):
	direction = dir

func set_texture(texture):
	for child in get_children():
		if child.has_method("set_texture"):
			child.set_texture(texture)
			return
