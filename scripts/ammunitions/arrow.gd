extends "res://scripts/ammunitions/ammo.gd"

export(int) var gravity = 10

var velocity = Vector2()
var moving = true

func _ready():
	get_node("AnimationPlayer").play("moving")

func _fixed_process(delta):
	if moving == false:
		if !get_node("AnimationPlayer").is_playing():
			queue_free()
		return
	velocity.y += gravity * delta

	set_global_rot(-velocity.angle_to(Vector2(1, 0)))

	move(velocity)

	if is_out_of_bound():
		queue_free()
	elif is_colliding():
		var collider = get_collider()
		moving = false
		set_collision_mask(0)
		get_node("AnimationPlayer").play("hit")
		if collider.has_method("take_damages"):
			collider.take_damages(1)

func set_velocity(vel):
	velocity = vel
	if velocity.x < 0:
		get_node("Sprite").set_flip_v(true)