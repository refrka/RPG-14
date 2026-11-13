extends Node


signal overlay_removed(overlay: Overlay)

signal overlay_added(overlay: Overlay)



var dialogue_overlay: DialogueOverlay

var container_overlay: ContainerOverlay


var overlay_stack: Array

var pause_count:= 0




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	dialogue_overlay = get_tree().get_first_node_in_group("dialogue_overlay")

	dialogue_overlay.last_line_input.connect(_on_dialogue_last_line_input)

	container_overlay = get_tree().get_first_node_in_group("container_overlay")




func add_overlay(overlay: Overlay) -> void:

	if not overlay_stack.has(overlay):

		overlay_stack.append(overlay)

		overlay.show()

		if overlay.request_pause:

			pause_count += 1

			if not Game.is_paused():

				Game.pause()

		overlay_added.emit(overlay)




func remove_overlay(overlay: Overlay) -> void:

	if overlay_stack.has(overlay):

		overlay_stack.erase(overlay)

		overlay.hide()

		if overlay.request_pause and pause_count > 0:

			pause_count -= 1

			if pause_count == 0:

				Game.unpause()

		overlay_removed.emit(overlay)












func show_dialogue_node(dialogue_node: DialogueNode) -> void:

	if not dialogue_overlay.visible:

		add_overlay(dialogue_overlay)

	dialogue_overlay.set_dialogue_text(dialogue_node.dialogue_text)





func hide_dialogue() -> void:

	remove_overlay(dialogue_overlay)





func show_container(entity: Entity) -> void:

	add_overlay(container_overlay)

	container_overlay.load_container(entity)



func hide_container() -> void:

	remove_overlay(container_overlay)







func _on_dialogue_last_line_input() -> void:

	hide_dialogue()