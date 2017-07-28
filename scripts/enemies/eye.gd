extends "res://scripts/enemies/enemy.gd"

var velocity = Vector2()
var gravity = 20

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	velocity.y += gravity * delta
	
	var motion = move(velocity)
	
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)

func on_death():
	queue_free()