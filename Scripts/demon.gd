extends Area2D

@onready var attack = get_node("Attack")

var targets : Array[Area2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if targets.size() > 0:
		#attack.set_target(targets[0])
	#var enemies = get_overlapping_areas()
	#if enemies: #TODO: make another node named attack (this can be carried in the demon resource, and call its attack function)
		#for enemy in enemies:
			##target the furthest enemy
			#enemy.damage(delta*10)
			


func _on_area_entered(area):
	targets.append(area)
	targets.sort_custom(func(a,b): return a.get_parent().progress > b.get_parent().progress)
	attack.set_target(targets[0])


func _on_area_exited(area):
	targets.erase(area)
	if targets.size() > 0:
		attack.set_target(targets[0])
	else:
		attack.set_target(null)
	
