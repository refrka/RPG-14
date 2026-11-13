class_name InteractionSensor extends Sensor


signal interactable_entered(_entity: Entity)

signal interactable_exited(_entity: Entity)


var interactable_entities: Array



func initialize(_entity: Entity = null) -> void:

	super(_entity)

	entity_entered.connect(_on_entity_entered)

	entity_exited.connect(_on_entity_exited)



func refresh() -> void:

	interactable_entities.clear()

	for _entity in get_overlapping_bodies():

		if _entity.is_interactable():

			interactable_entities.append(_entity)




func _on_entity_entered(_entity: Entity) -> void:

	if _entity.is_interactable() and not interactable_entities.has(_entity):

		interactable_entities.append(_entity)

		interactable_entered.emit(_entity)



func _on_entity_exited(_entity: Entity) -> void:

	if interactable_entities.has(_entity):

		interactable_entities.erase(_entity)

		interactable_exited.emit(_entity)