class_name ItemSlot extends MarginContainer


signal stack_updated


@export var default_stylebox: StyleBox

@export var hovered_stylebox: StyleBox

@export var group_selected_stylebox: StyleBox

@export var cursor_selected_stylebox: StyleBox


@export var panel: PanelContainer

@export var icon_texture_rect: TextureRect

@export var count_label: Label



var stack: ItemStack

var cursor_selected:= false

var group_selected:= false

var hovered:= false



func _ready() -> void:

	gui_input.connect(_on_gui_input)

	mouse_entered.connect(_on_mouse_entered)

	mouse_exited.connect(_on_mouse_exited)





func is_empty() -> bool:

	return stack == null or stack.is_empty()




func set_stack(_stack: ItemStack) -> void:

	stack = _stack

	update_visuals()

	stack_updated.emit()




func set_hover_state(state: bool) -> void:

	hovered = state

	update_visuals()



func set_cursor_selected_state(state: bool) -> void:

	cursor_selected = state

	update_visuals()



func set_group_selected_state(state: bool) -> void:

	group_selected = state

	update_visuals()




func update_visuals() -> void:

	icon_texture_rect.modulate = Color.WHITE

	icon_texture_rect.modulate.a = 1.0

	count_label.text = "" if (not stack or stack.count <= 1) else str(stack.count)

	if stack:

		icon_texture_rect.texture = stack.item.icon_texture

	else:

		icon_texture_rect.texture = null

	var stylebox = default_stylebox

	match [hovered, cursor_selected, group_selected]:

		[_, true, false]:

			stylebox = cursor_selected_stylebox

			icon_texture_rect.modulate = Color.BLACK

			icon_texture_rect.modulate.a = 0.5

		[true, false, false]:

			stylebox = hovered_stylebox

	panel.add_theme_stylebox_override("panel", stylebox)




func can_accept_item(_item: Item) -> bool:

	return true



func can_accept_stack(_item_stack: ItemStack) -> bool:

	return can_accept_item(_item_stack.item)




func _on_gui_input(event: InputEvent) -> void:

	if visible and event is InputEventMouseButton:

		Cursor.handle_item_slot_input(event, self)



func _on_mouse_entered() -> void:

	Cursor.handle_item_slot_hover(true, self)



func _on_mouse_exited() -> void:

	Cursor.handle_item_slot_hover(false, self)