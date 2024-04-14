extends Node2D

class_name Tower

@export var carrier : Area2D
@export var hell : Area2D
@export var summon1 : Area2D
@export var summon2 : Area2D
@export var summon3 : Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_summon_1_input_event(_viewport, event, _shape_idx):
	if Global.build_mode and event is InputEventMouseButton and event.is_pressed():
		carrier.reparent(summon1,false)
		hide_circles(true)


func _on_summon_2_input_event(_viewport, event, _shape_idx):
	if Global.build_mode and event is InputEventMouseButton and event.is_pressed():
		carrier.reparent(summon2,false)
		hide_circles(true)

func _on_summon_3_input_event(_viewport, event, _shape_idx):
	if Global.build_mode and event is InputEventMouseButton and event.is_pressed():
		carrier.reparent(summon3,false)
		hide_circles(true)

func _on_carrier_input_event(_viewport, event, _shape_idx):
	if Global.build_mode and event is InputEventMouseButton and event.is_pressed():
		if carrier.get_parent().name != "Hell":
			carrier.reparent(hell,false)
			hide_circles(false)
		#else:
			##TODO: upgrade demon

		
func hide_circles(hide_sprite):
	if hide_sprite:
		hell.get_node("Sprite2D").self_modulate.a = 0
		summon1.get_node("Sprite2D").self_modulate.a = 0
		summon2.get_node("Sprite2D").self_modulate.a = 0
		summon3.get_node("Sprite2D").self_modulate.a = 0
	else:
		hell.get_node("Sprite2D").self_modulate.a = 1
		summon1.get_node("Sprite2D").self_modulate.a = 1
		summon2.get_node("Sprite2D").self_modulate.a = 1
		summon3.get_node("Sprite2D").self_modulate.a = 1
		

