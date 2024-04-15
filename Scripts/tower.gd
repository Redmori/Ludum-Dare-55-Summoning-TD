extends Node2D

class_name Tower

@export var carrier : Area2D
@export var hell : Area2D
@export var summon1 : Area2D
@export var summon2 : Area2D
@export var summon3 : Area2D

@export var tutorial : Node2D

var carrier_loc = 0

var interactable = true

var upgrade_level = 1
var open_upgrades

# Called when the node enters the scene tree for the first time.
func _ready():
	if tutorial:
		if Global.tutorial2_started or Global.tutorial2_done:
			tutorial.queue_free()
		else:
			tutorial.visible = true
			

func set_upgrades(upgr):
	open_upgrades = upgr
	
	if upgrade_level == 1:
		if not upgr[3]:
			get_node("Hell").get_node("Upgr3").queue_free()
		if not upgr[4]:
			get_node("Hell").get_node("Upgr4").queue_free()
		if not upgr[1]:
			get_node("Hell").get_node("Upgr1").queue_free()
		if not upgr[6]:
			get_node("Hell").get_node("Upgr6").queue_free()
	elif upgrade_level == 2:
		if not upgr[1]:
			get_node("Hell").get_node("Upgr1").queue_free()
		if not upgr[6]:
			print("delete down")
			get_node("Hell").get_node("Upgr6").queue_free()
	elif upgrade_level == 3:
		if not upgr[3]:
			get_node("Hell").get_node("Upgr3").queue_free()
		if not upgr[4]:
			get_node("Hell").get_node("Upgr4").queue_free()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func sprite_flash():
	var tween: Tween = create_tween() 
	tween.tween_property(carrier, "modulate:v", 1, 0.075).from(15)
	
func fade_out(object):
	var tween: Tween = create_tween() 
	tween.tween_property(object.get_node("Sprite2D"), "self_modulate", Color(1,1,1,0), 0.5) #, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

func _on_summon_1_input_event(_viewport, event, _shape_idx):
	if interactable and Global.build_mode and event is InputEventMouseButton and event.is_pressed() and carrier_loc == 0:
		carrier.reparent(summon1,false)
		change_location(1)


func _on_summon_2_input_event(_viewport, event, _shape_idx):
	if interactable and Global.build_mode and event is InputEventMouseButton and event.is_pressed() and carrier_loc == 0:
		carrier.reparent(summon2,false)
		change_location(2)

func _on_summon_3_input_event(_viewport, event, _shape_idx):
	if interactable and Global.build_mode and event is InputEventMouseButton and event.is_pressed() and carrier_loc == 0:
		carrier.reparent(summon3,false)
		change_location(3)

func change_location(n):
		hide_circles(true, n)
		if not $Audio.playing:
			$Audio.play()
		sprite_flash()
		carrier_loc = n
		start_timer()
		reset_highlights()
		if tutorial != null and not Global.tutorial2_done:
			tutorial.queue_free()
			Global.do_tutorial2()
		carrier.get_node("Demon").line = n

func _on_carrier_input_event(_viewport, event, _shape_idx):
	if interactable and Global.build_mode and event is InputEventMouseButton and event.is_pressed() and carrier_loc != 0:
		if carrier.get_parent().name != "Hell":
			carrier.reparent(hell,false)
			hide_circles(false, 0)
			carrier_loc = 0
			start_timer()
			reset_highlights()
			carrier.get_node("Demon").line = 0
		#else:
			##TODO: upgrade demon

func reset():
	if carrier.get_parent().name != "Hell":
		carrier.reparent(hell,false)
		hide_circles(false, 0)
		carrier_loc = 0
		reset_highlights()
		

		
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


func reset_highlights():
	summon1.get_node("Sprite2D").self_modulate.b = 1
	summon2.get_node("Sprite2D").self_modulate.b = 1
	summon3.get_node("Sprite2D").self_modulate.b = 1
	carrier.modulate.b = 1

func _on_summon_1_mouse_entered():
	if carrier_loc == 0:
		summon1.get_node("Sprite2D").self_modulate.b = 0
		carrier.modulate.b = 0


func _on_summon_1_mouse_exited():	
	summon1.get_node("Sprite2D").self_modulate.b = 1
	carrier.set_deferred("modulate.b", 1)
	carrier.modulate.b = 1
	


func _on_summon_2_mouse_entered():
	if carrier_loc == 0:
		summon2.get_node("Sprite2D").self_modulate.b = 0
		carrier.modulate.b = 0


func _on_summon_2_mouse_exited():
	summon2.get_node("Sprite2D").self_modulate.b = 1
	set_deferred("modulate.b", 1)
	carrier.modulate.b = 1


func _on_summon_3_mouse_entered():
	if carrier_loc == 0:
		summon3.get_node("Sprite2D").self_modulate.b = 0
		carrier.modulate.b = 0


func _on_summon_3_mouse_exited():
	summon3.get_node("Sprite2D").self_modulate.b = 1
	set_deferred("modulate.b", 1)
	carrier.modulate.b = 1
