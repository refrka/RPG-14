class_name DialogueNode extends Resource


@export var dialogue_text: DialogueText

@export var options: Array[DialogueOption]












static func create(_dialogue_text: DialogueText) -> DialogueNode:

	var node = DialogueNode.new()

	node.dialogue_text = _dialogue_text

	return node