class_name CombatAttackingState extends CombatState


signal attack_animation_finished


var movement_component: MovementComponent

var attack_modifier: Modifier



func initialize(_entity: Entity, _state_machine: StateMachine) -> void:

	super(_entity, _state_machine)

	movement_component = entity.get_component(MovementComponent)





func enter() -> void:

	super()

	animation_component.combat_anim_player.animation_finished.connect(_on_combat_animation_finished, CONNECT_ONE_SHOT)

	var anim_name = combat_component.get_animation_name()

	if movement_component:

		var operator: Modifier.Operator

		if combat_component.current_attack_entry.speed_modifier_value == 0.0:

			operator = Modifier.Operator.OVERRIDE

		else:

			operator = Modifier.Operator.MULTIPLY

		attack_modifier = Modifier.new_passive(combat_component.current_attack_entry.speed_modifier_value, operator)

		movement_component.modifier_tracker.add_modifier(attack_modifier)

	animation_component.play_combat_anim(anim_name)



func exit() -> void:

	super()

	if attack_modifier and movement_component:

		movement_component.modifier_tracker.remove_modifier(attack_modifier)

		attack_modifier = null




func _on_combat_animation_finished(anim_name: StringName) -> void:

	if anim_name == combat_component.get_animation_name():

		attack_animation_finished.emit()





