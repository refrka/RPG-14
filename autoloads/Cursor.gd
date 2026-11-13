extends Node



var cursor_slot: CursorSlot



var group_hover_enabled:= false

var group_select_enabled:= false



var hovered_slot: ItemSlot

var group_hovered_slots: Array

var group_selected_slots: Array

var cursor_selected_slot: ItemSlot







func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS





func select_slot(item_slot: ItemSlot) -> void:

	if not group_select_enabled and cursor_selected_slot:

		cursor_selected_slot.set_cursor_selected_state(false)

	cursor_selected_slot = item_slot

	cursor_slot.copied_slot = item_slot

	cursor_slot.set_stack(item_slot.stack)

	item_slot.set_cursor_selected_state(true)






func drop_slot() -> void:

	cursor_slot.set_stack(null)

	cursor_slot.copied_slot = null

	cursor_selected_slot.set_cursor_selected_state(false)

	cursor_selected_slot = null














func handle_item_slot_hover(state: bool, item_slot: ItemSlot) -> void:

	if state == false:

		if group_select_enabled:

			set_group_hovered_slot(item_slot, state)

		else:

			if not cursor_selected_slot == item_slot and group_selected_slots.has(item_slot):

				item_slot.hovered = false

				hovered_slot = null

	else:

		hovered_slot = item_slot

	item_slot.set_hover_state(state)








func handle_item_slot_input(event: InputEvent, item_slot: ItemSlot) -> void:

	match [item_slot.is_empty(), cursor_slot.is_empty(), event.button_index, event.is_pressed()]:

		# Left click down

		[true, true, 1, true]: # Empty slot, empty cursor

			pass

		[false, true, 1, true]: # Occupied slot, empty cursor

			select_slot(item_slot)

		[false, false, 1, true]: # Occupied slot, occupied cursor

			if item_slot.can_accept_stack(cursor_selected_slot.stack) and cursor_selected_slot.can_accept_stack(item_slot.stack):

				var temp_stack = item_slot.stack

				item_slot.set_stack(cursor_slot.stack)

				cursor_selected_slot.set_stack(temp_stack)

				cursor_slot.set_stack(temp_stack)

				drop_slot()

		[true, false, 1, true]: # Empty slot, occupied cursor

			if item_slot.can_accept_stack(cursor_selected_slot.stack):

				item_slot.set_stack(cursor_slot.stack)

				cursor_selected_slot.set_stack(null)

				drop_slot()

		# Right click down

		[_, false, 2, true]: # Any slot, occupied cursor

			drop_slot()








func set_group_hovered_slot(item_slot: ItemSlot, state: bool) -> void:

	if state == true:

		group_hovered_slots.append(item_slot)

	else:

		group_hovered_slots.erase(item_slot)








func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.button_index == 2 and event.is_pressed() and not cursor_slot.is_empty():

		drop_slot()