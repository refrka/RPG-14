class_name PlayerInteractionComponent extends InteractionComponent










func start_interaction(_entity: Entity) -> void:

	super(_entity)

	Events.fire(InteractionStartedEvent, {"entity": _entity})







func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("interact"):

		interaction_sensor.refresh()

		try_interaction()
