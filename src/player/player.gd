extends Spatial

signal clicked(node, click_position)

var _is_highlighted: bool = false

# when the mouse-button is down AND mouse is still hovering over
var _is_half_clicked: bool = false


# Sets the color of the token and its lights
func set_color(color: Color) -> void:
	$bottom_light.light_color = color
	$SpotLight.light_color = color
	$StaticBody/player_mesh.get_surface_material(0).albedo_color = color


# Sets the height of the token (useful for preventing z-fighting)
func set_height(height: float) -> void:
	$StaticBody/player_mesh.mesh.height = height
	$StaticBody/player_mesh2.mesh.height = height + 0.02
	translation.y = height/2 + 0.04

# Highlighting will brighten the outline and add extra lighting to token.
func set_highlighted(state: bool) -> void:
	_is_highlighted = state
	$SpotLight.visible = state
	$StaticBody/CollisionShape.disabled = state
	var color = (Color.white if state else Color.black)
	$StaticBody/player_mesh2.get_surface_material(0).albedo_color = color


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
