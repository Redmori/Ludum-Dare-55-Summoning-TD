extends Node2D

var wave_number = 1
@export var waves : Array[Wave]

var fully_done = true
var path1_done = true
var path2_done = true
var path3_done = true


# Called when the node enters the scene tree for the first time.
func _ready():
	$Path1.line = 3
	$Path2.line = 1
	$Path3.line = 2
	display_predictions()
	pass

func send_wave():
	if not Global.tutorial2_done:
		return
	Global.build_mode = false
	Global.base._on_wave_manager_mouse_exited()
	if wave_number > waves.size():
		return
	fully_done = false
	if not Global.tutorial3_done:
		Global.do_tutorial3()
	hide_predictions()
	if waves[wave_number -1].path1_types.size() > 0:
		$Path1.assign_wave(waves[wave_number-1].duration, waves[wave_number-1].path1_types, waves[wave_number-1].path1_amounts)
		path1_done = false
	if waves[wave_number-1].path2_types.size() > 0:
		$Path2.assign_wave(waves[wave_number-1].duration, waves[wave_number-1].path2_types, waves[wave_number-1].path2_amounts)
		path2_done = false
	if waves[wave_number-1].path3_types.size() > 0:
		$Path3.assign_wave(waves[wave_number-1].duration, waves[wave_number-1].path3_types, waves[wave_number-1].path3_amounts)
		path3_done = false


func _input(event):
	if fully_done and Input.is_action_just_pressed("next_wave"):
		send_wave()

func check_done():
	if path1_done and path2_done and path3_done:
		Global.earn(waves[wave_number -1].reward)
		wave_number += 1
		fully_done = true
		Global.build_mode = true
		Global.end_wave(wave_number)
		display_predictions()

func display_predictions():
	if wave_number > waves.size():
		return
	if waves[wave_number - 1].path1_types.size() > 0:
		$arrow_1.visible = true
		for type in waves[wave_number - 1].path1_types:
			if type.name == "Speedy":
				$fast_1.visible = true
			if type.name == "Dude":
				$basic_1.visible = true
			if type.name == "Fatty":
				$slow_1.visible = true
	if waves[wave_number - 1].path2_types.size() > 0:
		$arrow_2.visible = true
		for type in waves[wave_number - 1].path2_types:
			if type.name == "Speedy":
				$fast_2.visible = true
			if type.name == "Dude":
				$basic_2.visible = true
			if type.name == "Fatty":
				$slow_2.visible = true
	if waves[wave_number - 1].path3_types.size() > 0:
		$arrow_3.visible = true
		for type in waves[wave_number - 1].path3_types:
			if type.name == "Speedy":
				$fast_3.visible = true
			if type.name == "Dude":
				$basic_3.visible = true
			if type.name == "Fatty":
				$slow_3.visible = true
			

func hide_predictions():
	$arrow_1.visible = false
	$arrow_2.visible = false
	$arrow_3.visible = false
	$fast_1.visible = false
	$fast_2.visible = false
	$fast_3.visible = false
	$basic_1.visible = false
	$basic_2.visible = false
	$basic_3.visible = false
	$slow_1.visible = false
	$slow_2.visible = false
	$slow_3.visible = false

func _on_path_1_child_exiting_tree(node):
	if $Path1.spawning_done() and $Path1.get_children().size() == 1:
		path1_done = true
		check_done()


func _on_path_2_child_exiting_tree(node):
	if $Path2.spawning_done() and $Path2.get_children().size() == 1:
		path2_done = true
		check_done()


func _on_path_3_child_exiting_tree(node):
	if $Path3.spawning_done() and $Path3.get_children().size() == 1:
		path3_done = true
		check_done()


func _on_input_event(viewport, event, shape_idx):
	if fully_done and event is InputEventMouseButton and event.is_pressed():
		send_wave()
