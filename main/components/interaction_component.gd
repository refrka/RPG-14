class_name InteractionComponent extends Component



@export var interaction_sensor: InteractionSensor


 
var current_interaction_target: Entity

var current_interactable_component: InteractableComponent







func initialize(_entity: Entity) -> void:

	super(_entity)

	interaction_sensor.initialize(_entity)

	var movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.face_dir_changed.connect(_on_face_dir_changed)



func activate() -> void:

	super()

	interaction_sensor.activate()




func deactivate() -> void:

	super()

	interaction_sensor.deactivate()








func set_interaction_target(_entity: Entity) -> void:

	current_interaction_target = _entity

	current_interactable_component = null if not _entity else _entity.get_interactable_component()




func get_nearest_interactable() -> Entity:

	var nearest_entity: Entity = null

	var nearest_distance:= INF

	for _entity in interaction_sensor.interactable_entities:

		var distance = entity.distance_to_entity(_entity)

		if not nearest_entity or distance < nearest_distance:

			nearest_entity = _entity

			nearest_distance = distance

	return nearest_entity





func try_interaction() -> void:

	if is_interacting():

		if current_interactable_component.has_method("repeat"):

			current_interactable_component.repeat()

		else:

			end_interaction()
	
	else:

		var _entity = get_nearest_interactable()

		if _entity:

			var interactable_component = _entity.get_interactable_component()

			if interactable_component.can_interact():

				start_interaction(_entity)




func start_interaction(_entity: Entity) -> void:

	set_interaction_target(_entity)

	current_interactable_component.ended.connect(_on_current_interaction_ended, CONNECT_ONE_SHOT)

	current_interactable_component.start()

	entity.state_machine.request_body_state(BodyInteractingState)




func stop_interaction() -> void:

	pass



func cancel_interaction() -> void:

	pass



func end_interaction() -> void:

	current_interactable_component.end()

	set_interaction_target(null)

	entity.state_machine.request_body_state(BodyIdleState)




func is_interacting() -> bool:

	return current_interaction_target and current_interactable_component and entity.state_machine.current_body_state is BodyInteractingState






func _on_face_dir_changed(dir: Vector2) -> void:

	interaction_sensor.rotation = dir.angle()





func _on_current_interaction_ended() -> void:

	set_interaction_target(null)

	entity.state_machine.request_body_state(BodyIdleState)