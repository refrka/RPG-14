class_name EffectsComponent extends Component



var active_effects: Array[Effect]








func add_effect(effect: Effect) -> void:

	effect.set_target(entity)

	if effect is InstantEffect:

		effect.apply()

	else:

		active_effects.append(effect)

		if effect is PassiveEffect:

			effect.apply()




func _process(delta: float) -> void:

	if not active:

		return

	for effect in active_effects:

		effect.tick(delta)