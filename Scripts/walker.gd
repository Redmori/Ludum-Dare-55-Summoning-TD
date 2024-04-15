extends PathFollow2D

var modified_speed
@export var speed = 30
var line : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var old_pos = position
	progress += delta * modified_speed
	var direction = position - old_pos
	if direction.x < 0 and abs(direction.x) > abs(direction.y):
		$Enemy.get_node("Sprite2D").flip_h = true
	elif direction.x > 0  and abs(direction.x) > abs(direction.y):
		$Enemy.get_node("Sprite2D").flip_h = false
	

func set_stats(stats):
	speed = stats.speed
	modified_speed = speed
	$Enemy.get_node("Sprite2D").sprite_frames = stats.texture
	$Enemy.get_node("Sprite2D").play()
	$Enemy.set_max_hp(stats.health)
	$Enemy.worth = stats.worth	
	
func modify_speed(multi, duration):
	modified_speed = speed*multi
	await get_tree().create_timer(duration).timeout
	modified_speed = speed
