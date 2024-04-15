extends TileMap

@export var indicator : Area2D

@export var tutorial1: Sprite2D
@export var tutorial2: Sprite2D

var tower = preload("res://Scenes/tower.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	indicate_tile(get_local_mouse_position())
	
func indicate_tile(local_position):
	var tile = local_to_map(local_position)
	var tile_data = get_cell_tile_data(0,tile)
	if Global.build_mode and tile_data and tile_data.get_custom_data("buildable") and Global.blood >= 10:
		var local_pos = map_to_local(tile)
		indicator.position = local_pos
		if not indicator.get_overlapping_areas():
			indicator.visible = true
		else: 
			indicator.visible = false
	else:
		indicator.visible = false
		
func _input(event):
	if Global.build_mode and event is InputEventMouseButton:
		if Input.is_action_pressed("Build") and indicator.visible and not indicator.get_overlapping_areas():
			var tile = local_to_map(indicator.position)
			var tile_data = get_cell_tile_data(0,tile)
			if tile_data and tile_data.get_custom_data("buildable") and Global.pay(10):
				var local_pos = map_to_local(tile)		
				var new_tower = tower.instantiate()
				add_child(new_tower)
				new_tower.position = local_pos
				
				#check all the new tower upgrade spots				
				var open_upgrades = [false, false, false, false, false, false, false, false]
				
				var right = get_cell_tile_data(0,tile+Vector2i(1, 0))
				if right and right.get_custom_data("buildable"):
					open_upgrades[4] = true
					
				var left = get_cell_tile_data(0,tile+Vector2i(-1, 0))
				if left and left.get_custom_data("buildable"):
					open_upgrades[3] = true
					
				var up = get_cell_tile_data(0,tile+Vector2i(0, -1))
				if up and up.get_custom_data("buildable"):
					open_upgrades[1] = true
					
				var down = get_cell_tile_data(0,tile+Vector2i(0, 1))
				if down and down.get_custom_data("buildable"):
					open_upgrades[6] = true
					
				var topleft = get_cell_tile_data(0,tile+Vector2i(-1, -1))
				if topleft and topleft.get_custom_data("buildable"):
					open_upgrades[0] = true
					
				var topright = get_cell_tile_data(0,tile+Vector2i(1, -1))
				if topright and topright.get_custom_data("buildable"):
					open_upgrades[2] = true
					
				var botleft = get_cell_tile_data(0,tile+Vector2i(-1, 1))
				if botleft and botleft.get_custom_data("buildable"):
					open_upgrades[5] = true
					
				var botright = get_cell_tile_data(0,tile+Vector2i(1, 1))
				if botright and botright.get_custom_data("buildable"):
					open_upgrades[7] = true
					
				new_tower.set_upgrades(open_upgrades)
				
				Global.add_tower(new_tower)
				if tutorial1.visible:
					tutorial1.visible = false
		elif Input.is_action_pressed("Destroy") and indicator.visible and indicator.get_overlapping_areas():
			for area in indicator.get_overlapping_areas():
				if area.get_parent() is Tower:
					area.get_parent().queue_free() #TODO: return some money
	
