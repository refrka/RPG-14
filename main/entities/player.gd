class_name Player extends Character




func initialize() -> bool:

	inventory = PlayerInventory.from_inventory(inventory)

	super()

	Events.fire(PlayerInitializedEvent)

	Events.subscribe(EntityDiedEvent, _on_entity_died)

	return true






func get_component(script: Script) -> Component:

	script = PlayerMovementComponent if script == MovementComponent else script

	script = PlayerCombatComponent if script == CombatComponent else script

	return super(script)








func _on_entity_died(event: Event) -> void:

	var entity = event.data.entity

	var damage_package = entity.hurtbox.damage_package_history.back()

	if damage_package.source_entity == self:

		print("Player killed ", entity.entity_def.entity_id)