class_name PlayerCombatComponent extends CombatComponent










		




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("attack") and Inputs.is_action_allowed("attack"):

		if not is_attacking() and can_attack():

			execute_attack()