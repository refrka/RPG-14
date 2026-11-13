class_name DialogueOverlay extends Overlay


signal dialogue_text_complete

signal last_line_input



@export var panel: PanelContainer

@export var dialogue_text_label: RichTextLabel

@export var next_label: Label

@export var options_vbox: VBoxContainer


var current_dialogue_text: DialogueText

var current_line_index:= 0





func _ready() -> void:

	super()

	panel.gui_input.connect(_on_gui_input)

	




func set_dialogue_text(dialogue_text: DialogueText) -> void:

	current_dialogue_text = dialogue_text

	show_line(0)

	update_next_label()

	




func show_line(index: int) -> void:

	current_line_index = index

	var line = current_dialogue_text.lines[index]

	dialogue_text_label.text = line

	if is_last_line(current_line_index):

		dialogue_text_complete.emit()

	update_next_label()



func show_next() -> void:

	if is_last_line(current_line_index):

		last_line_input.emit()

	else:

		show_line(current_line_index + 1)






func update_next_label() -> void:

	next_label.text = "[ . . . ]" if not is_last_line(current_line_index) else "[ x ]"





func is_last_line(index: int) -> bool:

	if current_dialogue_text:

		return current_dialogue_text.lines.size() - 1 == index

	return false







func _on_gui_input(event: InputEvent) -> void:

	if not visible or not Inputs.is_action_allowed("interact"):

		return

	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():

		if is_last_line(current_line_index):

			last_line_input.emit()

		else:

			show_next()