class_name BodyIdleState extends BodyState




func initialize(_entity: Entity, _state_machine: StateMachine) -> void:

	super(_entity, _state_machine)

	var movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.move_started.connect(_on_move_started)






func _on_move_started() -> void:

	if active:

		state_machine.request_body_state(BodyMovingState)