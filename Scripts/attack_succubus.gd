extends Attack

@export var damage : int
@export var slow_mod : float
@export var slow_duration : float


func do_attack(target):
	$AnimatedSprite2D.play()
	$Audio.play()
	var hits = $Area2D.get_overlapping_areas()
	for hit in hits:
		hit.get_parent().modify_speed(slow_mod,slow_duration)
		hit.damage(damage)
