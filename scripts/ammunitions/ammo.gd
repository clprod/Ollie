extends KinematicBody2D

func _ready():
	set_fixed_process(true)

func is_out_of_bound():
	return get_pos().x < 0 or get_pos().y < 0 or get_pos().x > get_viewport_rect().size.width or get_pos().y > get_viewport_rect().size.height