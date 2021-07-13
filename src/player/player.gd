extends Spatial

signal clicked(node, click_position)

var _is_highlighted: bool = false

# when the mouse-button is down AND mouse is still hovering over
var _is_half_clicked: bool = false

func set_highlighted(state: bool) -> void:
	_is_highlighted = state
	$SpotLight.visible = state

func _on_StaticBody_input_event(camera: Node, event: InputEvent, click_position: Vector3, click_normal: Vector3, shape_idx: int) -> void:
	if not (event is InputEventMouseButton):
		return
	if not (event.button_index == BUTTON_LEFT):
		return
	if event.pressed == true:
		_is_half_clicked = true
	if (event.pressed == false) and (_is_half_clicked):
		emit_signal("clicked", self, click_position)

func _on_StaticBody_mouse_exited() -> void:
	_is_half_clicked = false
