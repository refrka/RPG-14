extends Node


var player: Player:

	get:

		if not player:

			player = get_tree().get_first_node_in_group("player")

		if not player:

			player = load("res://main/entities/player.tscn").instantiate()

			get_current_location().add_character(player, Vector2(150.0, 150.0))

		return player




var root: Node




func _ready() -> void:

	root = get_tree().get_first_node_in_group("root")

	player.initialize()

	player.activate()




func get_current_location() -> Location:

	return get_tree().get_first_node_in_group("location")

