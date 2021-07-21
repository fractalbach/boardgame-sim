extends Node

var textures = {}

var CARD_BACK_TEXTURE = load("res://greek_cards/0_back.jpg")

var FILENAMES = [
	'10_clubs.jpeg',
	'10_diamonds.jpeg',
	'10_hearts.jpeg',
	'10_spades.jpeg',
	'2_all_suits.jpeg',
	'3_all_suits.jpeg',
	'4_all_suits.jpeg',
	'5_all_suits.jpeg',
	'6_clubs.jpeg',
	'6_diamonds.jpeg',
	'6_hearts.jpeg',
	'6_spades.jpeg',
	'7_clubs.jpeg',
	'7_diamonds.jpeg',
	'7_hearts.jpeg',
	'7_spades.jpeg',
	'8_clubs.jpeg',
	'8_diamonds.jpeg',
	'8_hearts.jpeg',
	'8_spades.jpeg',
	'9_clubs.jpeg',
	'9_diamonds.jpeg',
	'9_hearts.jpeg',
	'9_spades.jpeg',
	'ace_all_suits.jpeg',
	'jack_clubs.jpeg',
	'jack_diamonds.jpeg',
	'jack_hearts.jpeg',
	'jack_spades.jpeg',
	'joker_1.jpeg',
	'joker_2.jpeg',
	'king_clubs.jpeg',
	'king_diamonds.jpeg',
	'king_hearts.jpeg',
	'king_spades.jpeg',
	'queen_clubs.jpeg',
	'queen_diamonds.jpeg',
	'queen_hearts.jpeg',
	'queen_spades.jpeg',
]

var SUITS = {
	1: "spades",
	2: "hearts",
	3: "diamonds",
	4: "clubs",
}

var FACE_NUMS = {
	11: "jack",
	12: "queen",
	13: "king",
}


func _init() -> void:
	for filename in FILENAMES:
		var t = load("res://greek_cards/" + filename)
		textures[filename] = t


func get_texture(suit: int, num: int):
	if num <= 0:
		return CARD_BACK_TEXTURE
	if num == 1:
		return textures["ace_all_suits.jpeg"]
	if num <= 5:
		return textures[str(num) + "_all_suits.jpeg"]
	if num <= 10:
		return textures[str(num) + "_" + SUITS[suit] + ".jpeg"]
	if num <= 13:
		return textures[FACE_NUMS[num] + "_" + SUITS[suit] + ".jpeg"]
	return CARD_BACK_TEXTURE


