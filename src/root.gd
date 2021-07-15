extends Spatial

var Player = preload("res://player/player.tscn")

var selected_object: Node = null
var players = []


func _ready() -> void:
	$board.connect("clicked", self, "_on_board_clicked")
	init_players()


func init_players() -> void:
	var examples = [Color.red, Color.deepskyblue, Color.limegreen, Color.purple]
	for i in range(len(examples)):
		var color = examples[i]
		var loc = Vector2(0, i * 0.2)
		var p = new_player(color, loc)
		p.set_height(0.1 + 0.01 * i)
		players.push_back(p)


func new_player(color: Color, location: Vector2) -> Node:
	var p = Player.instance()
	add_child(p)
	p.connect("clicked", self, "_on_player_clicked")
	p.set_color(color)
	p.translation.x = location.x
	p.translation.z = location.y
	return p


func _on_player_clicked(node, click_pos) -> void:
	if selected_object != null:
		return
	select(node)


func _on_board_clicked(node, click_pos) -> void: 
	if selected_object != null:
		selected_object.translation.x = click_pos.x
		selected_object.translation.z = click_pos.z
		unselect(selected_object)


func _on_StaticBody_input_event(camera: Node, event: InputEvent, click_position: Vector3, click_normal: Vector3, shape_idx: int) -> void:
	if selected_object == null:
		return
	if event is InputEventMouseMotion:
		selected_object.translation.x = click_position.x
		selected_object.translation.z = click_position.z



func select(node):
	selected_object = node
	selected_object.set_highlighted(true)
	for p in players: 
		p.get_node("StaticBody").input_ray_pickable = false


func unselect(node):
	selected_object.set_highlighted(false)
	selected_object = null
	for p in players: 
		p.get_node("StaticBody").input_ray_pickable = true

