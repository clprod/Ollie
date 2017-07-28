extends "res://scripts/weapons/weapon.gd"

export(PackedScene) var bullet_scene
export(Texture) var bullet_texture

export var shooting_power = 500
export var loading_time = 0.2
export var spread_power = 3

var last_time_shoot = 0
var shooting = false

func _process(delta):
	last_time_shoot -= delta

	if !shooting:
		return

	if last_time_shoot <= 0:
		shoot()
		last_time_shoot = loading_time

func on_shoot_pressed():
	shooting = true

func on_shoot_released():
	shooting = false

func shoot():
	var offset = (get_global_mouse_pos() - get_global_pos()).normalized()
	
	var bullet = bullet_scene.instance()
	bullet.set_texture(bullet_texture)
	bullet.set_direction(offset.rotated(deg2rad(rand_range(-spread_power, spread_power))))
	bullet.set_rot(-offset.angle_to(Vector2(1, 0)))
	bullet.set_speed(shooting_power)
	bullet.set_pos(get_global_pos())
	get_node("../..").add_child(bullet)