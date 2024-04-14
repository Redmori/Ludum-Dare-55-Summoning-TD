extends Node

var wave = 1
var blood = 35
var build_mode = true

var towers : Array[Node2D]

func pay(amount):
	if blood - amount >= 0:
		blood -= amount
		return true
	else:
		return false

func earn(amount):
	blood += amount
	#print(blood)

func add_tower(new_tower):
	towers.append(new_tower)
	
func end_wave():
	print("ending wave")
	for tower in towers:
		tower.reset()
