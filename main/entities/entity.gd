class_name Entity extends PhysicsBody2D

@export var entity_def: EntityDef

@export var inventory:= Inventory.new()

@export var body_sprite: Sprite2D

@export var combat_root: Node2D

@export var hitbox: Hitbox

@export var hurtbox: Hurtbox

@export var component_root: Node

@export var state_machine: StateMachine

@export var center_marker: Marker2D

@export var audio_player: AudioStreamPlayer



var active:= false

var initialized:= false





func initialize() -> bool:

	assert(entity_def != null, "Missing entity def for %s" % self.name)

	if initialized:

		return false

	initialized = true

	if not self is Player:

		inventory = inventory.duplicate(true)
	
	inventory.initialize()
	
	if hitbox:

		hitbox.initialize(self)

	if hurtbox:

		hurtbox.initialize(self)

	if state_machine:

		state_machine.initialize(self)

	if component_root:

		get_all_components().map(func(c): c.initialize(self))

	return true




func activate() -> void:

	active = true

	if hitbox:

		hitbox.activate()

	if hurtbox:

		hurtbox.activate()

	if component_root:

		get_all_components().map(func(c): c.activate())

	if state_machine:

		state_machine.activate()





func deactivate() -> void:

	active = false

	if hitbox:

		hitbox.deactivate()

	if hurtbox:

		hurtbox.deactivate()

	if component_root:

		get_all_components().map(func(c): c.deactivate())

	if state_machine:

		state_machine.deactivate()









func distance_to_entity(entity: Entity) -> float:

	return global_position.distance_to(entity.global_position)




func direction_to_entity(entity: Entity, invert:= false) -> Vector2:

	var dir = global_position.direction_to(entity.global_position)

	if invert:

		dir = -dir

	return dir











func is_interactable() -> bool:

	return get_interactable_component() != null


func is_busy() -> bool:

	return state_machine.current_body_state is BodyBusyState













func get_component(script: Script) -> Component:

	for component in get_all_components():

		if component.get_script() == script:

			return component

	return null




func get_interactable_component() -> InteractableComponent:

	for component in get_all_components():

		if component is InteractableComponent:

			return component

	return null



func get_all_components(active_only:= false) -> Array:

	var components = component_root.get_children()

	if active_only:

		components = components.filter(func(c): return c.active)

	return components



func add_component(script: Script) -> void:

	var component = script.new()

	component_root.add_child(component)

	component.initialize(self)



func remove_component(script: Script) -> void:

	var component = get_component(script)

	if component:

		component.deactivate()

		component_root.remove_child(component)








func die() -> void:

	get_all_components().map(func(c): c._on_death())

	Events.fire(EntityDiedEvent, {"entity": self})




func expire() -> void:

	deactivate()

	Events.fire(EntityExpiredEvent, {"entity": self})