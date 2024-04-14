extends PathFollow2D

@export var speed = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += delta * speed

func set_stats(stats):
	speed = stats.speed
	$Enemy.get_node("Sprite2D").texture = stats.texture
	$Enemy.set_max_hp(stats.health)
	$Enemy.worth = stats.worth	
