extends Sprite

func _ready():
	set_process(true)

func _process(delta):
	var mouse_pos = get_global_mouse_pos()
	
	if mouse_pos.x < get_global_pos().x:
		set_flip_v(true)
	else:
		set_flip_v(false)

	set_rot(-(mouse_pos - get_global_pos()).angle_to(Vector2(1, 0)))

func on_shoot_pressed():
	pass

func on_shoot_released():
	pass

func shoot():
	pass