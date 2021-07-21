extends Spatial

var Player = preload("res://player/player.tscn")
var Card = preload("res://card/card.tscn")

var selected_object: Node = null
var players = []
var cards = []
var rng = RandomNumberGenerator.new()


func _ready() -> void:
	randomize()
	rng.randomize()
	$board.connect("clicked", self, "_on_board_clicked")
	$CardDeck.connect("clicked", self, "_on_deck_clicked")
	init_players()
	# init_cards()


func init_players() -> void:
	var examples = [Color.red, Color.deepskyblue, Color.limegreen, Color.purple]
	for i in range(len(examples)):
		var color = examples[i]
		# var loc = Vector2(0, i * 0.2)
		var loc = Vector2((randf()-0.5) * 4, (randf()-0.5) * 2)
		var p = new_player(color, loc)
		# p.set_height(0.1 + 0.01 * i)
		p.set_height(0.1 + 0.01)
		players.push_back(p)

#
#func init_cards() -> void:
#	for i in range(10):
#		var loc = Vector2((randf()-0.5) * 4, (randf()-0.5) * 2)
#		var suit = rng.randi_range(1,4)
#		var num = rng.randi_range(1,13)
#		var c = new_card(loc, suit, num)
#		cards.push_back(c)
#	return


func new_player(color: Color, location: Vector2) -> Node:
	var p = Player.instance()
	add_child(p)
	p.connect("clicked", self, "_on_player_clicked")
	p.set_color(color)
	p.translation.x = location.x
	p.translation.z = location.y
	return p


func new_card(location: Vector3, suit: int, num: int) -> Node:
	var c = Card.instance()
	c.set_card(suit, num)
	c.connect("clicked", self, "_on_card_clicked")
	add_child(c)
	c.translation = location
	return c


func _on_player_clicked(node, click_pos) -> void:
	if selected_object != null:
		return
	select(node)


func _on_card_clicked(node, click_pos) -> void:
	if selected_object != null:
		return
	select(node)


func _on_deck_clicked(node, click_pos) -> void:
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
	for c in cards: 
		c.get_node("StaticBody").input_ray_pickable = false


func unselect(node):
	selected_object.set_highlighted(false)
	selected_object = null
	for p in players: 
		p.get_node("StaticBody").input_ray_pickable = true
	for c in cards:
		c.get_node("StaticBody").input_ray_pickable = true



func _on_CardDeck_card_drawn(node, card_array) -> void:
	var suit = card_array[0]
	var num = card_array[1]
	var r = rng.randf_range(0.4, 0.6)
	var theta = rng.randf_range(0, 2*PI)
	var xdiff = r * cos(theta)
	var zdiff = r * sin(theta)
	var loc = $CardDeck.translation + Vector3(xdiff, 0, zdiff)
	var c = new_card(loc, suit, num)
	cards.push_back(c)

