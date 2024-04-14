extends Attack

@export var projectile : PackedScene
@export var damage : int
#@export var cooldown : float

func do_attack(target):
	var new_projectile = projectile.instantiate()
	add_child(new_projectile)
	new_projectile.target = target
	new_projectile.damage = damage
	#target.damage(30)

