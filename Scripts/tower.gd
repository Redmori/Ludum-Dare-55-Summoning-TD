extends Node2D

class_name Tower

@export var carrier : Area2D
@export var hell : Area2D
@export var summon1 : Area2D
@export var summon2 : Area2D
@export var summon3 : Area2D

var carrier_loc = 0

var interactable = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func sprite_flash():
	var tween: Tween = create_tween() 
	tween.tween_property(carrier, "modulate:v", 1, 0.75).from(15)
	
func fade_out(object):
	var tween: Tween = create_tween() 
	tween.tween_property(object.get_node("Sprite2D"), "self_modulate", Color(1,1,1,0), 0.5) #, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

func _on_summon_1_input_event(_viewport, event, _shape_idx):
	if interactable and Global.build_mode and event is InputEventMouseButton and event.is_pressed() and carrier_loc != 1:
		print("parent to sum1")
		carrier.reparent(summon1,false)
		hide_circles(true, 1)
		if not $Audio.playing:
			$Audio.play()
		sprite_flash()
		carrier_loc = 1
		start_timer()


func _on_summon_2_input_event(_viewport, event, _shape_idx):
	if interactable and Global.build_mode and event is InputEventMouseButton and event.is_pressed() and carrier_loc != 2:
		carrier.reparent(summon2,false)
		hide_circles(true ,2)
		if not $Audio.playing:
			$Audio.play()
		sprite_flash()
		carrier_loc = 2
		start_timer()

func _on_summon_3_input_event(_viewport, event, _shape_idx):
	if interactable and Global.build_mode and event is InputEventMouseButton and event.is_pressed() and carrier_loc != 3:
		carrier.reparent(summon3,false)
		hide_circles(true, 3)
		if not $Audio.playing:
			$Audio.play()
		sprite_flash()
		carrier_loc = 3
		start_timer()

func _on_carrier_input_event(_viewport, event, _shape_idx):
	if interactable and Global.build_mode and event is InputEventMouseButton and event.is_pressed() and carrier_loc != 0:
		if carrier.get_parent().name != "Hell":
			carrier.reparent(hell,false)
			hide_circles(false, 0)
			carrier_loc = 0
			start_timer()
		#else:
			##TODO: upgrade demon

func reset():
	if carrier.get_parent().name != "Hell":
		carrier.reparent(hell,false)
		hide_circles(false, 0)
		carrier_loc = 0
		

		
func hide_circles(hide_sprite, pos):
	if hide_sprite:
		hell.get_node("Sprite2D").self_modulate.a = 0
		if pos == 1:
			fade_out(summon1)
		else:
			summon1.get_node("Sprite2D").self_modulate.a = 0
		if pos == 2:
			fade_out(summon2)
		else:
			summon2.get_node("Sprite2D").self_modulate.a = 0
		if pos == 3:
			fade_out(summon3)
		else:
			summon3.get_node("Sprite2D").self_modulate.a = 0
	else:
		hell.get_node("Sprite2D").self_modulate.a = 1
		summon1.get_node("Sprite2D").self_modulate.a = 1
		summon2.get_node("Sprite2D").self_modulate.a = 1
		summon3.get_node("Sprite2D").self_modulate.a = 1
		

func start_timer():
	interactable = false
	$Timer.start()

func _on_timer_timeout():
	interactable = true
