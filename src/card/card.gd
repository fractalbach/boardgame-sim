extends Spatial

signal clicked(node, click_position)

var _is_highlighted: bool = false
var _is_half_clicked: bool = false
var _is_face_down: bool = false

var card_num = 0
var card_suit = 0


func _ready() -> void:
	_update_texture()


func set_face_down(state: bool):
	_is_face_down = state
	_update_texture()


func _update_texture() -> void:
	var texture
	if _is_face_down:
		texture = $CardLoader.CARD_BACK_TEXTURE
		print("card shown as down")
	else:
		texture = $CardLoader.get_texture(card_suit, card_num)
		print("displaying card face up!")
	$StaticBody/TopMesh.get_surface_material(0).albedo_texture = texture


func set_card(suit: int, num: int):
	if (suit < 1) or (suit > 4):
		suit = 1
	if (num < 0) or (num > 13):
		num = 0
	card_suit = suit
	card_num = num
	_update_texture()
	print("card set to ", card_suit, card_num)


func set_highlighted(state: bool) -> void:
	_is_highlighted = state
	$StaticBody/CollisionShape.disabled = state
	var color = (Color.white if state else Color.black)
	$StaticBody/MeshInstance2.get_surface_material(0).albedo_color = color


func _on_StaticBody_input_event(camera: Node, event: InputEvent, click_position: Vector3, click_normal: Vector3, shape_idx: int) -> void:
	if not (event is InputEventMouseButton):
		return
	if not (event.button_index == BUTTON_LEFT):
		return
	if event.pressed == true:
		_is_half_clicked = true
	if (event.pressed == false) and (_is_half_clicked):
		_is_half_clicked = false
		if (Input.is_key_pressed(KEY_SHIFT)):
			print('flipping card')
			set_face_down(!_is_face_down)
			return
		emit_signal("clicked", self, click_position)


func _on_StaticBody_mouse_exited() -> void:
	_is_half_clicked = false
