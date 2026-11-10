class_name Entity extends PhysicsBody2D

@export var entity_def: EntityDef

@export var body_sprite: Sprite2D

@export var component_root: Node

@export var state_machine: StateMachine

@export var anim_player: AnimationPlayer


var active:= false

var initialized:= false




func initialize() -> bool:

	assert(entity_def != null, "Missing entity def for %s" % self.name)

	if initialized:

		return false

	initialized = true

	get_all_components().map(func(c): c.initialize(self))

	state_machine.initialize(self)

	return true




func activate() -> void:

	active = true

	get_all_components().map(func(c): c.activate())

	state_machine.activate()





func deactivate() -> void:

	active = false

	get_all_components().map(func(c): c.deactivate())

	state_machine.deactivate()































func get_component(script: Script) -> Component:

	for component in get_all_components():

		if component.get_script() == script:

			return component

	return null




func get_all_components(active_only:= false) -> Array:

	var components = component_root.get_children()

	if active_only:

		components = components.filter(func(c): return c.active)

	return components