class_name Inventory extends Resource


signal weapon_updated


const BASE_SIZE = 3


signal index_updated(index: int, stack: ItemStack)


@export var stacks: Array[ItemStack]

@export var size:= BASE_SIZE



@export var weapon: ItemStack




func initialize() -> void:

	resize()

	for stack in stacks:

		if stack:

			stack.emptied.connect(_on_stack_emptied)



func clear() -> void:

	size = BASE_SIZE

	stacks.clear()




func resize(_size:= -1) -> void:

	if _size > 0:

		size = _size

	stacks.resize(size)



func get_item_stack(index: int) -> ItemStack:

	if stacks.size() - 1 >= index:

		return stacks[index]

	return null



func set_index(index: int, stack: ItemStack) -> void:

	if not size - 1 >= index:

		return

	if stacks.size() - 1 < index:

		resize()

	stacks[index] = stack

	index_updated.emit(index, stack)




func get_index(stack: ItemStack) -> int:

	return stacks.find(stack)




func get_first_empty_index() -> int:

	for i in range(stacks.size()):

		var stack = get_item_stack(i)

		if not stack or stack.is_empty():

			return i
		
	return -1



func get_stacks_with_item(item: Item) -> Array:

	var item_stacks = []

	for stack in stacks:

		if stack and stack.item == item:

			item_stacks.append(stack)

	return item_stacks




func set_weapon(_weapon: Weapon) -> void:

	weapon = ItemStack.create(_weapon)

	weapon_updated.emit()



func set_weapon_stack(stack: ItemStack) -> void:

	if weapon != stack:

		weapon = stack

		weapon_updated.emit()





func add_items(item: Item, amount:= 1) -> int:

	var matching_stacks = get_stacks_with_item(item)

	var remaining = amount

	while remaining > 0 and not matching_stacks.is_empty():

		var stack = matching_stacks.pop_back()

		remaining = stack.add_amount(remaining)

	var empty_index = get_first_empty_index()

	while remaining > 0 and empty_index != -1:

		var stack = get_item_stack(empty_index)

		if not stack:

			stack = ItemStack.create(item, remaining)

			remaining -= stack.count

			set_index(empty_index, stack)

		else:

			remaining = stack.add_amount(remaining)

		empty_index = get_first_empty_index()

	return remaining



func add_item_stack(item_stack: ItemStack) -> void:

	var remaining = add_items(item_stack.item, item_stack.count)

	item_stack.set_count(remaining)

	


func remove_items(item: Item, amount:= 1) -> int:

	var remaining = amount

	var matching_stacks = get_stacks_with_item(item)

	while remaining > 0 and not matching_stacks.is_empty():

		var stack = matching_stacks.pop_back()

		remaining = stack.remove_amount(remaining)

	return remaining






func is_empty() -> bool:

	for stack in stacks:

		if stack and not stack.is_empty():

			return false

	return true



func _on_stack_emptied(index: int) -> void:

	set_index(index, null)