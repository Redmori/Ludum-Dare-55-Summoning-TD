extends Path2D

#@export var enemy : PackedScene

#@export var spawn_timer = 2
#@export var current_timer = spawn_timer

@onready var basic_enemy = preload("res://Resources/Enemies/basic_enemy.tres")
@onready var walker = preload("res://Scenes/walker.tscn")

var enemy_types
var timers : Array[float]
var current_timers : Array[float]
var enemy_amounts

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func assign_wave(duration, new_types, amounts):
	enemy_types = new_types
	enemy_amounts = amounts
	timers = []
	for amount in amounts:
		timers.append(duration / amount)
	current_timers = timers.duplicate()
	for i in current_timers.size():
		current_timers[i] = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_timers:
		for i in current_timers.size():
			current_timers[i] -= delta
			if enemy_amounts[i] > 0 and current_timers[i] <= 0:
				spawn(enemy_types[i])
				enemy_amounts[i] -= 1
				current_timers[i] = timers[i]

func spawn(enemy_resource):
	var new_enemy = walker.instantiate()
	add_child(new_enemy)
	new_enemy.set_stats(enemy_resource)
	
func spawning_done():
	for i in enemy_amounts.size():
		if enemy_amounts[i] != 0:
			return false
	return true
