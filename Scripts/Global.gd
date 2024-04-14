extends Node

var wave = 1
var blood = 35
var build_mode = true

func pay(amount):
	if blood - amount >= 0:
		blood -= amount
		return true
	else:
		return false

func earn(amount):
	blood += amount
	#print(blood)
