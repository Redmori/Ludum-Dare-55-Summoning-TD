extends Area2D

@export var health = 100
@export var worth = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func damage(amount):
	health -= amount
	$ProgressBar.value = health
	if health <= 0:
		Global.earn(worth)
		get_parent().queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#damage(delta*10)
	pass

func set_max_hp(amount):
	$ProgressBar.max_value = amount
	$ProgressBar.value = amount
	health = amount
