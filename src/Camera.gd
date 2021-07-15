extends Camera

var MIN_ZOOM_HEIGHT = 0.1
var MAX_ZOOM_HEIGHT = 50

func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(BUTTON_MIDDLE):
			var v = Vector3(event.relative.x, event.relative.y, 0)
			v = v.rotated(Vector3(0,0,1), -rotation.y)
			translation.x -= v.x * 0.005
			translation.z -= v.y * 0.005
		elif Input.is_mouse_button_pressed(BUTTON_RIGHT):
			rotation.x -= event.relative.y * 0.005
			rotation.y -= event.relative.x * 0.005


	if event.is_action_pressed("ui_left"):
		translation.x -= 0.5
	if event.is_action_pressed("ui_right"):
		translation.x += 0.5
	if event.is_action_pressed("ui_down"):
		translation.z += 0.5
	if event.is_action_pressed("ui_up"):
		translation.z -= 0.5
	
		
	if event.is_action_pressed("quit_game"):
		get_tree().quit()
	
	
	if event.is_action_pressed("zoom_in"):
		if self.translation.y > MIN_ZOOM_HEIGHT: 
			self.translation.y -= 0.1
	
	if event.is_action_pressed("zoom_out"):
		if self.translation.y < MAX_ZOOM_HEIGHT:
			self.translation.y += 0.1
	
