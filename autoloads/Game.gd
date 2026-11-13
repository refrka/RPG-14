extends Node


signal game_state_changed(new_state: GameState)



enum GameState {

	MAIN_MENU,

	ACTIVE,

	PAUSED,

}




var player: Player:

	get:

		if not player:

			player = get_tree().get_first_node_in_group("player")

		if not player:

			player = load("res://main/entities/player.tscn").instantiate()

			get_current_location().add_character(player, Vector2(150.0, 150.0))

		return player




var root: Node

var game_state: GameState


func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	root = get_tree().get_first_node_in_group("root")






func change_state(new_state: GameState) -> void:

	game_state = new_state

	game_state_changed.emit(new_state)









func get_current_location() -> Location:

	return get_tree().get_first_node_in_group("location")







func pause() -> void:

	get_tree().paused = true



func unpause() -> void:

	get_tree().paused = false



func is_paused() -> bool:

	return get_tree().paused








func create_timer(duration: float) -> SceneTreeTimer:

	var timer = get_tree().create_timer(duration)

	return timer