extends Spatial

signal clicked(node, click_position)

var _is_half_clicked: bool = false

func _on_StaticBody_input_event(camera: Node, event: InputEvent, click_position: Vector3, click_normal: Vector3, shape_idx: int) -> void:
	if not (event is InputEventMouseButton):
		return
	if not (event.button_index == BUTTON_LEFT):
		return
	if event.pressed == true:
		_is_half_clicked = true
	if (event.pressed == false) and (_is_half_clicked):
		emit_signal("clicked", self, click_position)
