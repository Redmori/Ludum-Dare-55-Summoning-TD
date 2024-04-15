extends Node2D

class_name Attack

var target : Node2D
@export var cooldown : float

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = cooldown


func set_target(new_target):
	target = new_target


func _on_timer_timeout():
	if target:
		do_attack(target)

func do_attack(targ):
	pass
