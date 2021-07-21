extends Spatial

signal clicked(node, click_position)
signal card_drawn(node, card_array)
signal card_drawn_but_deck_empty(node)

var _is_half_clicked_left: bool = false
var rng = RandomNumberGenerator.new()
var cards = []


func _ready() -> void:
	
	randomize()
	
	# For Spades, use the full range Ace - King
	for num in range(1,14):
		cards.push_back([1, num])
	
	# For Hearts, Diamonds, Clubs, only use 6 to King
	for suit in range(2, 5):
		for num in range(6, 14):
			cards.push_back([suit, num])
	
	cards.shuffle()


func shuffle() -> void:
	$AnimationPlayer.play("spin")
	cards.shuffle()


func draw_card() -> Array:
	return cards.pop_front()


func add_card_and_shuffle(card: Array) -> void:
	cards.push_back(card)
	shuffle()


func set_highlighted(state: bool) -> void:
	# $SpotLight.visible = state
	$StaticBody/CollisionShape.disabled = state
	var color = (Color.white if state else Color.black)
	$StaticBody/Outline.get_surface_material(0).albedo_color = color


func _on_StaticBody_input_event(camera: Node, event: InputEvent, click_position: Vector3, click_normal: Vector3, shape_idx: int) -> void:

	if not (event is InputEventMouseButton):
		return
	
	if (event.button_index == BUTTON_LEFT):
		if event.pressed == true:
			_is_half_clicked_left = true
		
		elif (Input.is_key_pressed(KEY_SHIFT)):
			shuffle()
		
		elif (Input.is_key_pressed(KEY_CONTROL)):
			var card = draw_card()
			if (card == null):
				emit_signal("card_drawn_but_deck_empty", self)
			else: 
				emit_signal("card_drawn", self, card)
		
		elif (event.pressed == false) and (_is_half_clicked_left):
			emit_signal("clicked", self, click_position)


func _on_StaticBody_mouse_exited() -> void:
	_is_half_clicked_left = false
