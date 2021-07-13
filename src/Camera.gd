extends Camera


func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	
	if (
		Input.is_mouse_button_pressed(BUTTON_MIDDLE)
		and event is InputEventMouseMotion
	):
		self.translation.x -= event.relative.x * 0.005
		self.translation.z -= event.relative.y * 0.005
		
	if event.is_action_pressed("ui_left"):
		self.translation.x -= 0.5
	if event.is_action_pressed("ui_right"):
		self.translation.x += 0.5
	if event.is_action_pressed("ui_down"):
		self.translation.z += 0.5
	if event.is_action_pressed("ui_up"):
		self.translation.z -= 0.5
	
		
	if event.is_action_pressed("quit_game"):
		get_tree().quit()
	
	
	if event.is_action_pressed("zoom_in"):
		if self.translation.y > 1: 
			self.translation.y -= 0.5
	
	if event.is_action_pressed("zoom_out"):
		if self.translation.y < 50:
			self.translation.y += 0.5
	
