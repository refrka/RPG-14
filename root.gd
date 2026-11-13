extends Node



@export var input_configs: Array[InputConfig]

@export var entity_root: Node



func _ready() -> void:

	Inputs.input_configs = input_configs.duplicate(true)

	Game.change_state(Game.GameState.ACTIVE)

	for child in entity_root.get_children():

		if child is Entity:

			child.initialize()

			child.activate()
	