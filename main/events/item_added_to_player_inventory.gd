class_name ItemAddedToPlayerInventory extends GameEvent



@export var item: Item

@export var amount:= -1




func matches(event: Event) -> bool:

	if event.get_script() != get_script():

		return false

	if event.data.has("item"):

		if amount != -1:

			return event.data.item == item and event.data.amount == amount

		return event.data.item == item

	return false