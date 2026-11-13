class_name CursorSlot extends ItemSlot



var copied_slot: ItemSlot




func _ready() -> void:

	Cursor.cursor_slot = self



func _process(_delta: float) -> void:

	if not is_empty():

		global_position = get_global_mouse_position()
