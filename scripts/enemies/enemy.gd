extends KinematicBody2D

export(int) var max_health = 5

var healthbar

func _ready():
	for child in get_children():
		if child.has_method("take_damages"):
			healthbar = child
			healthbar.set_max_health(max_health)
			healthbar.set_current_health(max_health)
			break

func take_damages(amount):
	if healthbar == null:
		return
	healthbar.take_damages(amount)
	if is_dead():
		on_death()

func is_dead():
	return healthbar.current_health == 0

func on_death():
	pass