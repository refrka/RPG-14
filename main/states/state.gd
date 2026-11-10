class_name State extends Node


var active = false

var entity: Entity

var state_machine: StateMachine



func initialize(_entity: Entity, _state_machine: StateMachine) -> void:

	entity = _entity

	state_machine = _state_machine




func enter() -> void:

	active = true



func exit() -> void:

	active = false




func process(delta: float) -> void:

	pass



func physics_process(delta: float) -> void:

	pass