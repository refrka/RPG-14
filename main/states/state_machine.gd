class_name StateMachine extends Node



@export var body_state_root: Node

@export var initial_body_state: State



var state_registry: Dictionary[Script, State]

var active:= false

var entity: Entity

var current_body_state: BodyState





func initialize(_entity: Entity) -> void:

	entity = _entity

	for state in body_state_root.get_children():

		var script = state.get_script()

		state_registry[script] = state

		state.initialize(entity, self)

	if initial_body_state:

		current_body_state = initial_body_state





func activate() -> void:

	active = true

	if current_body_state:

		current_body_state.enter()




func deactivate() -> void:

	active = false

	if current_body_state:

		current_body_state.exit()




func request_body_state(script: Script) -> void:

	var state = get_state(script)

	if state:

		change_body_state(state)




func change_body_state(new_state: BodyState) -> void:

	if current_body_state == new_state and current_body_state.allow_reenter:

		current_body_state.enter()

	else:

		if current_body_state:

			current_body_state.exit()

		current_body_state = new_state

		current_body_state.enter()







func get_state(script: Script) -> State:

	if state_registry.has(script):

		return state_registry[script]

	return null






func _process(delta: float) -> void:

	if not active:

		return

	if current_body_state:

		current_body_state.process(delta)






func _physics_process(delta: float) -> void:

	if not active:

		return

	if current_body_state:

		current_body_state.physics_process(delta)