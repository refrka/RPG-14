class_name EntityRef extends Resource



@export var entity_id: StringName

@export var entity_def: EntityDef

@export var unique_id: int

@export var authored_id: int








func matches(entity: Entity) -> bool:

	if entity_id != "" and entity.entity_def.entity_id != entity_id:

		return false

	if entity_def and entity.entity_def != entity_def:

		return false

	return true






static func create(entity: Entity) -> EntityRef:

	var ref = EntityRef.new()

	ref.entity_id = entity.entity_def.entity_id

	ref.entity_def = entity.entity_def

	return ref