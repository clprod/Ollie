extends "res://scripts/enemies/enemy.gd"

export(NodePath) var player
export(float) var speed

var animation_player

func _ready():
	set_fixed_process(true)
	animation_player = get_node("AnimationPlayer")
	animation_player.play("idle")

func _fixed_process(delta):
	if is_dead():
		if !animation_player.is_playing():
			queue_free()
		return

	if player == null:
		return

	var direction = (get_node(player).get_global_pos() - get_global_pos()).normalized()
	if direction.x < 0:
		get_node("Sprite").set_flip_h(true)
	else:
		get_node("Sprite").set_flip_h(false)

	move(direction * speed * delta)

func on_death():
	animation_player.play("death")
	set_collision_mask(0)
	set_layer_mask(0)