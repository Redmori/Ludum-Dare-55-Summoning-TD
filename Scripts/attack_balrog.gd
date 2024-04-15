extends Attack

@export var dps : int
# Called when the node enters the scene tree for the first time.
var current_target


func _process(delta):
	print($Audio.volume_db)
	if current_target != null:
		$Area2D.look_at(current_target.global_position)
		var hits = $Area2D.get_overlapping_areas()
		for hit in hits:
			hit.damage(dps*delta)
		if not $Audio.playing:
			$Audio.play()
	else:
		$Area2D.get_node("AnimatedSprite2D").stop()
		$Area2D.get_node("AnimatedSprite2D").visible = false
		$Audio.stop()
		
		

func do_attack(target):
	if target:
		$Area2D.get_node("AnimatedSprite2D").visible = true
	current_target = target
	#$Area2D.look_at(target.global_position)
	$Area2D.get_node("AnimatedSprite2D").play()

