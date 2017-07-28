extends "res://scripts/weapons/weapon.gd"

export(PackedScene) var arrow_scene
export(float) var max_loading_time = 2
export(float) var min_power = 5
export(float) var max_power = 20

var loading = false
var loading_time = 0

const loading_frame_number = 4

func _process(delta):
	if loading:
		loading_time += delta
		if loading_time > max_loading_time:
			loading_time = max_loading_time
		set_frame(floor(loading_time * (loading_frame_number-1) / max_loading_time))


func on_shoot_pressed():
	loading = true
	loading_time = 0

func on_shoot_released():
	loading = false
	set_frame(4)
	if arrow_scene == null:
		return

	var shoot_power = loading_time * (max_power - min_power) / max_loading_time + min_power
	var direction = (get_global_mouse_pos() - get_global_pos()).normalized()

	var arrow = arrow_scene.instance()
	arrow.set_velocity(direction * shoot_power)
	arrow.set_pos(get_global_pos())
	get_node("../..").add_child(arrow)
	