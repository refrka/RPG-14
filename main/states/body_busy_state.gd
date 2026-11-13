class_name BodyBusyState extends BodyState




var movement_component: MovementComponent




func initialize(_entity: Entity, _state_machine: StateMachine) -> void:

	super(_entity, _state_machine)

	movement_component = entity.get_component(MovementComponent)

	



func enter() -> void:

	super()

	if movement_component:

		movement_component.deactivate()




func exit() -> void:

	super()

	if movement_component and entity.active:

		movement_component.activate()