extends Attack

@export var damage : int
# Called when the node enters the scene tree for the first time.
var current_target

func _process(delta):
	if current_target != null:
		$Area2D.global_position = current_target.global_position
		if current_target.global_position.x > global_position.x:
			get_parent().get_node("Sprite2D").flip_h = true
		else:
			get_parent().get_node("Sprite2D").flip_h = false
		

func do_attack(target):
	current_target = target
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.global_position = target.global_position
	$Area2D.global_position = current_target.global_position
	$Audio.play()
	var hits = $Area2D.get_overlapping_areas()
	for hit in hits:
		hit.damage(damage)
