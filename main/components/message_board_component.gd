class_name MessageBoardComponent extends InteractableComponent




@export var message_text: DialogueText




func can_interact() -> bool:

	return message_text != null



func start() -> void:

	var dialogue_node = DialogueNode.create(message_text)

	UI.overlay_removed.connect(_on_overlay_removed)

	UI.show_dialogue_node(dialogue_node)




func end() -> void:

	UI.overlay_removed.disconnect(_on_overlay_removed)

	UI.hide_dialogue()

	ended.emit()




func repeat() -> void:

	UI.dialogue_overlay.show_next()




func _on_overlay_removed(overlay: Overlay) -> void:

	if overlay == UI.dialogue_overlay:

		end()