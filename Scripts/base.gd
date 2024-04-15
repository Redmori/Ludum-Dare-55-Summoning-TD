extends Area2D

var cultists : Array[bool]
@export var cultist_sprites : Array[AnimatedSprite2D]

@export var cultist4_anim : AnimatedSprite2D
@export var cultist5_anim : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.base = self
	cultists = [true,true,true, true, true]
	update_blood(Global.blood)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_blood(amount):
	$Sprite2D.frame = min($Sprite2D.hframes-1 ,amount/10)

func _on_area_entered(area):
	area.get_parent().queue_free()
	var line_death = area.get_parent().line
	if line_death == 0:
		return
	if not cultists[line_death - 1]:
		$GameOver.visible = true
		await get_tree().create_timer(10).timeout
		get_tree().reload_current_scene()
	elif cultists[3]:		
		cultists[3] = false
		cultist_sprites[3].play()
		await cultist_sprites[3].animation_finished
		cultist_sprites[3].queue_free()
		#cultist_sprites[3].visible = false		
	elif cultists[4]:
		cultists[4] = false
		cultist_sprites[4].play()
		await cultist_sprites[4].animation_finished
		cultist_sprites[4].queue_free()
		#cultist_sprites[4].visible = false
	else:
		cultists[line_death-1] = false		
		cultist_sprites[line_death-1].play()
		await cultist_sprites[line_death-1].animation_finished
		cultist_sprites[line_death-1].queue_free()
		#cultist_sprites[line_death-1].visible = false
	
	
	

func set_wave(wave):
	$WaveCounter.frame = wave - 1

func _on_wave_manager_mouse_entered():
	if Global.build_mode:		
		$WaveCounter.modulate.s = 0.3

func _on_wave_manager_mouse_exited():
	$WaveCounter.modulate.s = 0
