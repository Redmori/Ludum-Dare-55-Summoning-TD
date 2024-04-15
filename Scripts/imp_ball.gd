extends Area2D

var target
var speed = 150
var damage
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target != null:
		velocity = global_position.direction_to(target.global_position)*speed*delta
		translate(velocity)
	else:
		queue_free()

func _on_area_entered(area):
	if area == target:
		target.damage(damage)
		queue_free()
