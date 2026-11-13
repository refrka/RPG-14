class_name WorldAnimationNode extends Node2D


@export var anim_player: AnimationPlayer

@export var sprite: Sprite2D

@export var hitbox: Hitbox





func _ready() -> void:

	hitbox.initialize()

	hitbox.activate()

	hitbox.entity_hit.connect(_on_entity_hit)










func _on_entity_hit(entity: Entity) -> void:

	print(entity)