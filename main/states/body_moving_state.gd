class_name BodyMovingState extends BodyState


var animation_component: AnimationComponent

var movement_component: MovementComponent


func initialize(_entity: Entity, _state_machine: StateMachine) -> void:

	super(_entity, _state_machine)

	movement_component = entity.get_component(MovementComponent)

	movement_component.move_ended.connect(_on_move_ended)

	movement_component.face_dir_changed.connect(_on_face_dir_changed)

	animation_component = entity.get_component(AnimationComponent)




func enter() -> void:

	super()

	var anim_name = "walk_down" if movement_component.face_dir.y >= 0.0 else "walk_up"

	animation_component.play_body_anim("%s/%s" % [entity.entity_def.entity_id, anim_name])



func exit() -> void:

	super()

	var anim_name = "idle_down" if movement_component.face_dir.y >= 0.0 else "idle_up"

	animation_component.play_body_anim("%s/%s" % [entity.entity_def.entity_id, anim_name])



func _on_move_ended() -> void:

	if active:

		state_machine.request_body_state(BodyIdleState)





func _on_face_dir_changed(dir: Vector2) -> void:

	if not active:

		return

	var anim_name = "walk_down" if movement_component.face_dir.y >= 0.0 else "walk_up"

	animation_component.play_body_anim("%s/%s" % [entity.entity_def.entity_id, anim_name])