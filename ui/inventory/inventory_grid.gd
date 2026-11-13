class_name InventoryGrid extends GridContainer


@onready var item_slot_scene:= preload("res://ui/inventory/item_slot.tscn")


var inventory: Inventory







func clear() -> void:

	clear_grid()

	inventory = null





func clear_grid() -> void:

	for child in get_children():

		child.queue_free()




func set_inventory(_inventory: Inventory) -> void:

	inventory = _inventory

	load_inventory_grid()




func load_inventory_grid() -> void:

	if not inventory:

		return
	
	clear_grid()

	for i in range(inventory.size):

		var stack = inventory.get_item_stack(i)

		var item_slot = item_slot_scene.instantiate()

		item_slot.stack_updated.connect(_on_slot_stack_updated.bind(item_slot, i))

		item_slot.set_stack(stack)

		add_child(item_slot)

	

func _on_slot_stack_updated(item_slot: ItemSlot, index: int) -> void:

	inventory.set_index(index, item_slot.stack)

