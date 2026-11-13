class_name InteractionStartedEvent extends GameEvent


@export var entity_ref: EntityRef






func matches(event: Event) -> bool:

	if event.get_script() != get_script():

		return false

	if event.data.has("entity"):

		return entity_ref.matches(event.data.entity)

	return false