class_name ContainerOverlay extends Overlay



@export var player_inventory_grid: InventoryGrid

@export var container_inventory_grid: InventoryGrid





func clear() -> void:

	player_inventory_grid.clear()

	container_inventory_grid.clear()




func load_container(entity: Entity) -> void:

	container_inventory_grid.set_inventory(entity.inventory)

	player_inventory_grid.set_inventory(Game.player.inventory)