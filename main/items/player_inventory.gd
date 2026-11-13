class_name PlayerInventory extends Inventory



func add_items(item: Item, amount:= 1) -> int:

	var remaining = super(item, amount)

	Events.fire(ItemAddedToPlayerInventory, {"item": item, "amount": amount - remaining})

	return remaining



static func from_inventory(inventory: Inventory) -> PlayerInventory:

	var player_inventory = PlayerInventory.new()

	player_inventory.size = inventory.size

	player_inventory.stacks = inventory.stacks.duplicate(true)

	player_inventory.weapon = inventory.weapon.duplicate(true)

	return player_inventory