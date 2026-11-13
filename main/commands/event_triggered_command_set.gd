class_name EventTriggeredCommandSet extends CommandSet


@export var event_trigger: Event

@export var one_time:= true







func enable_trigger() -> void:

	var script = event_trigger.get_script()

	Events.subscribe(script, _on_event_trigger)





func _on_event_trigger(event: Event) -> void:

	if event_trigger.matches(event):

		execute_all()

		if one_time:

			Events.unsubscribe(event_trigger.get_script(), _on_event_trigger)






