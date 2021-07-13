extends Spatial

var selected_object: Node = null

func _ready() -> void:
	$player.connect("clicked", self, "_on_player_clicked")
	$board.connect("clicked", self, "_on_board_clicked")

func _on_player_clicked(node, click_pos) -> void:
	if selected_object == node:
		selected_object.set_highlighted(false)
		selected_object = null
		# print("Object Un-selected")
	else:
		selected_object = node
		selected_object.set_highlighted(true)
		# print("Selected Object:", selected_object)

func _on_board_clicked(node, click_pos) -> void: 
	if selected_object != null:
		selected_object.translation.x = click_pos.x
		selected_object.translation.z = click_pos.z
