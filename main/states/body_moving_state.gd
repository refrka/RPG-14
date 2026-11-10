class_name BodyMovingState extends BodyState


var animation_component: AnimationComponent


func initialize(_entity: Entity, _state_machine: StateMachine) -> void:

	super(_entity, _state_machine)

	var movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.move_ended.connect(_on_move_ended)

	animation_component = entity.get_component(AnimationComponent)




func enter() -> void:

	super()

	animation_component.play_body_anim("%s/walk_down" % entity.entity_def.entity_id)



func exit() -> void:

	super()

	animation_component.play_body_anim("RESET")



func _on_move_ended() -> void:

	if active:

		state_machine.request_body_state(BodyIdleState)