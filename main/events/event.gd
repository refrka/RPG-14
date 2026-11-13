class_name Event extends Resource



@export var data: Dictionary





func fire() -> void:

	pass



func matches(event: Event) -> bool:

	return event.get_script() == get_script() and event.data == data