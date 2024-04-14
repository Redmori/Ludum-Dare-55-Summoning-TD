extends Area2D

var cultists : Array[bool]
@export var cultist_sprites : Array[Sprite2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.base = self
	cultists = [true,true,true, true, true]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(area):
	area.get_parent().queue_free()
	var line_death = area.get_parent().line
	if line_death == 0:
		return
	if not cultists[line_death - 1]:
		$GameOver.visible = true
	elif cultists[3]:
		cultists[3] = false
		cultist_sprites[3].visible = false		
	elif cultists[4]:
		cultists[4] = false
		cultist_sprites[4].visible = false
	else:
		cultists[line_death-1] = false
		cultist_sprites[line_death-1].visible = false
	
	
	

func set_wave(wave):
	$WaveCounter.frame = wave - 1

func _on_wave_manager_mouse_entered():
	if Global.build_mode:
		$WaveCounter.modulate.g = 0


func _on_wave_manager_mouse_exited():
	$WaveCounter.modulate.g = 1
