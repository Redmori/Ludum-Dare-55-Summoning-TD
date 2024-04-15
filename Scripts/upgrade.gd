extends Area2D


@export var upgrade_tower: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	if Global.blood >= 10:
		$ReferenceRect.visible = true
	


func _on_mouse_exited():
	$ReferenceRect.visible = false
	



func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and Input.is_action_pressed("Build") and Global.pay(10):
		var new_tower = upgrade_tower.instantiate()
		add_child(new_tower)
		new_tower.reparent(get_parent().get_parent().get_parent(),true)
		Global.add_tower(new_tower)
		var this_tower = get_parent().get_parent()
		Global.remove_tower(this_tower)
		var new_upgrades = [false, false, false, false, false, false, false, false]
		if this_tower.upgrade_level == 1: #standard imp
			if self.name == "Upgr3":
				new_tower.upgrade_level = this_tower.upgrade_level + 1
				if this_tower.open_upgrades[0] and this_tower.open_upgrades[1]:
					new_upgrades[1] = true
				if this_tower.open_upgrades[5] and this_tower.open_upgrades[6]:
					new_upgrades[6] = true
			elif self.name == "Upgr4":
				new_tower.upgrade_level = this_tower.upgrade_level + 1
				if this_tower.open_upgrades[1] and this_tower.open_upgrades[2]:
					new_upgrades[1] = true
				if this_tower.open_upgrades[6] and this_tower.open_upgrades[7]:					
					new_upgrades[6] = true
					
			elif self.name == "Upgr1":
				new_tower.upgrade_level = this_tower.upgrade_level + 2
				if this_tower.open_upgrades[0] and this_tower.open_upgrades[3]:
					new_upgrades[3] = true
				if this_tower.open_upgrades[2] and this_tower.open_upgrades[4]:					
					new_upgrades[4] = true
			elif self.name == "Upgr6":
				new_tower.upgrade_level = this_tower.upgrade_level + 2
				if this_tower.open_upgrades[3] and this_tower.open_upgrades[5]:
					new_upgrades[3] = true
				if this_tower.open_upgrades[4] and this_tower.open_upgrades[7]:					
					new_upgrades[4] = true			
			
			new_tower.set_upgrades(new_upgrades)
			
		this_tower.queue_free()


func _on_area_entered(area):
	if area.name == "Hell" and area != get_parent():
		queue_free()
