extends Area2D

@onready var attack = get_node("Attack")

var targets : Array[Area2D]
var line : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_area_entered(area):
	if area.get_parent().line == line:
		targets.append(area)
		targets.sort_custom(func(a,b): return a.get_parent().progress > b.get_parent().progress)
		attack.set_target(targets[0])


func _on_area_exited(area):
	targets.erase(area)
	if targets.size() > 0:
		attack.set_target(targets[0])
	else:
		attack.set_target(null)
	
