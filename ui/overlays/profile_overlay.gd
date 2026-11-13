class_name ProfileOverlay extends Overlay



@export var weapon_slot: EquipmentSlot

@export var inventory_grid: InventoryGrid




func _ready() -> void:

	super()

	Events.subscribe(PlayerInitializedEvent, _on_player_initialized)

	weapon_slot.stack_updated.connect(_on_weapon_stack_updated)





func _on_player_initialized(_event: Event) -> void:

	var inventory = Game.player.inventory

	inventory_grid.set_inventory(inventory)

	if inventory.weapon and not inventory.weapon.is_empty():

		weapon_slot.set_stack(inventory.weapon)

	inventory.weapon_updated.connect(_on_weapon_updated)





func _on_weapon_stack_updated() -> void:

	Game.player.inventory.set_weapon_stack(weapon_slot.stack)



func _on_weapon_updated() -> void:

	if weapon_slot.stack != Game.player.inventory.weapon:

		weapon_slot.set_stack(Game.player.inventory.weapon)




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("profile"):

		if visible:

			UI.remove_overlay(self)

			Inputs.enable_action("interact")

		else:

			UI.add_overlay(self)

			Inputs.disable_action("interact")



