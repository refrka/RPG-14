class_name Location extends Node2D





@export var location_id: StringName

@export var character_root: Node2D

@export var prop_root: Node2D

@export var pickup_root: Node2D





func add_character(character: Character, target_position: Vector2) -> void:

	character_root.add_child(character)

	character.global_position = target_position



func add_prop(prop: Prop, target_position: Vector2) -> void:

	prop_root.add_child(prop)

	prop.global_position = target_position