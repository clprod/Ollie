extends KinematicBody2D

export var size = Vector2(30, 30)

# movements
var velocity = Vector2()
var gravity = 20
var max_speed = 4
var acceleration = 10
var drag = 40
var jump_power = 10

func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if event.is_action("shoot"):
		if event.is_pressed():
			on_shoot_pressed()
		else:
			on_shoot_released()

func on_shoot_pressed():
	for child in get_children():
		if child.has_method("on_shoot_pressed"):
			child.on_shoot_pressed()
			return

func on_shoot_released():
	for child in get_children():
		if child.has_method("on_shoot_released"):
			child.on_shoot_released()
			return

func _fixed_process(delta):
	velocity.y += gravity * delta
	var grounded = test_move(Vector2(0, velocity.y))
	
	if Input.is_action_pressed("move_left"):
		if velocity.x > 0:
			velocity.x = 0
		if velocity.x > -max_speed:
			velocity.x -= acceleration * delta
	elif Input.is_action_pressed("move_right"):
		if velocity.x < 0:
			velocity.x = 0
		if velocity.x < max_speed:
			velocity.x += acceleration * delta
	else:
		if grounded:
			if velocity.x < -1:
				velocity.x += drag * delta
			elif velocity.x > 1:
				velocity.x -= drag * delta
			else:
				velocity.x = 0

	if grounded and Input.is_action_pressed("jump"):
		velocity.y = -jump_power

	var motion = move(velocity)
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)

func _draw():
	draw_rect(Rect2(Vector2() - size / 2, size), Color(255, 255, 255, 255))