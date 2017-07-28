extends Node2D

export(int) var max_width
export(int) var height = 5

var current_health
var max_health

func set_current_health(health):
	current_health = health
	if current_health < 0:
		current_health = 0
	update()

func set_max_health(health):
	max_health = health
	update()

func take_damages(amount):
	set_current_health(current_health - amount)

func _draw():
	if current_health == max_health:
		return

	var width = current_health * max_width / max_health
	var health_ratio = float(current_health) / max_health
	var color = null

	if health_ratio <= 0.25:
		color = Color(255, 0, 0)
	elif health_ratio <= 0.5:
		color = Color(125, 125, 0)
	elif health_ratio <= 0.75:
		color = Color(50, 200, 0)
	else:
		color = Color(0, 255, 0)

	draw_rect(Rect2(Vector2(-width/2, -height/2), Vector2(width, height)), color)