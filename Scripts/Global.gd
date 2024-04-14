extends Node

var wave = 1
var blood = 35
var build_mode = true

var tutorial2_started = false
var tutorial2_done = false
var tutorial3_done = false

var towers : Array[Node2D]
var base : Area2D

func pay(amount):
	if blood - amount >= 0:
		blood -= amount
		base.update_blood(blood)
		return true
	else:
		return false

func earn(amount):
	blood += amount
	base.update_blood(blood)
	#print(blood)

func add_tower(new_tower):
	towers.append(new_tower)
	if not tutorial2_started and towers.size() == 1:
		tutorial2_started = true
	
func end_wave(number):
	wave = number
	print("ending wave")
	for tower in towers:
		tower.reset()
	base.set_wave(wave)

func do_tutorial2():
	tutorial2_done = true
	base.get_node("Tutorial3").visible = true
	
func do_tutorial3():
	tutorial3_done = true
	base.get_node("Tutorial3").queue_free()
