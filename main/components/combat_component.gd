class_name CombatComponent extends Component




var current_weapon: Weapon

var current_attack_entry: AttackEntry




func initialize(_entity: Entity) -> void:

	super(_entity)

	var attacking_state = entity.state_machine.get_state(CombatAttackingState)

	attacking_state.attack_animation_finished.connect(_on_attack_animation_finished)

	current_weapon = entity.inventory.weapon.item

	if current_weapon:

		entity.hitbox.set_attack_entry(current_weapon.attack_entry)

		current_attack_entry = current_weapon.attack_entry

	var movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.face_dir_changed.connect(_on_face_dir_changed)

	entity.inventory.weapon_updated.connect(_on_weapon_updated)




func execute_attack() -> void:

	entity.state_machine.request_combat_state(CombatAttackingState)




func finish_attack() -> void:

	entity.state_machine.request_combat_state(CombatIdleState)

	entity.hitbox.clear()




func get_animation_name() -> StringName:

	return &"%s/attack" % [&"unarmed" if not current_weapon else current_weapon.item_id]




func is_attacking() -> bool:

	return entity.state_machine.current_combat_state is CombatAttackingState



func can_attack() -> bool:

	return current_attack_entry != null



func _on_attack_animation_finished() -> void:

	finish_attack()



func _on_face_dir_changed(dir: Vector2) -> void:

	if not is_attacking():

		entity.combat_root.rotation = dir.angle()



func _on_weapon_updated() -> void:

	if entity.inventory.weapon:

		current_weapon = entity.inventory.weapon.item

		current_attack_entry = current_weapon.attack_entry

	else:

		current_weapon = null

		current_attack_entry = null