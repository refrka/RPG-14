class_name ItemStack extends Resource


signal item_updated(new_item: Item)

signal count_updated(new_count: int)

signal emptied



@export var item: Item

@export var item_data: ItemData

@export var count:= -1







func clear() -> void:

	set_item(null, -1)






func set_item(_item: Item, _count:= 1) -> void:

	item = _item

	set_count(_count)

	item_updated.emit(item)





func set_count(_count: int) -> void:

	if count != _count:

		count = _count

		count_updated.emit(count)

		if count <= 0:

			emptied.emit()




func add_amount(amount: int) -> int:

	var space = item.max_stack - count

	var remaining = amount

	if remaining > space:

		set_count(item.max_stack)

		remaining -= space

	else:

		var new_count = count + remaining

		set_count(new_count)

		remaining = 0
	
	return remaining




func remove_amount(amount: int) -> int:

	var remaining = amount

	if count >= remaining:

		var new_count = count - remaining

		set_count(new_count)

	else:

		remaining -= count

		set_count(0)
	
	return remaining




func merge(stack: ItemStack) -> int:

	if not is_empty():

		return add_amount(stack.count)

	else:

		set_item(stack.item, stack.count)

		return 0





func is_empty() -> bool:

	return item == null or count <= 0



func can_merge(stack: ItemStack) -> bool:

	return is_empty() or item == stack.item






static func create(_item: Item, _count:= 1) -> ItemStack:

	var stack = ItemStack.new()

	stack.item = _item

	stack.count = min(_item.max_stack, _count)

	return stack