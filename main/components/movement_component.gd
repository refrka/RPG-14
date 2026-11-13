class_name MovementComponent extends Component



signal move_started

signal move_ended

signal face_dir_changed(dir: Vector2)



var face_dir: Vector2

var modifier_tracker:= ModifierTracker.new()




func initialize(_entity: Entity) -> void:

	super(_entity)

	entity.hurtbox.damage_package_received.connect(_on_damage_package_received)



func halt() -> void:

	entity.velocity = Vector2.ZERO



func deactivate() -> void:

	halt()

	super()



func get_move_dir() -> Vector2:

	return Vector2.ZERO



func get_move_speed() -> float:

	var override = modifier_tracker.get_float_override()

	if override != -1.0:

		return override

	return 50.0 + modifier_tracker.get_float_add()



func get_move_velocity() -> Vector2:

	

	return (get_move_dir() * get_move_speed()) + modifier_tracker.get_vector()



func get_gravity() -> float:

	return 0.0




func set_face_dir(dir: Vector2) -> void:

	if dir == face_dir:

		return

	face_dir = dir

	face_dir_changed.emit(dir)




func _on_damage_package_received(damage_package: DamagePackage) -> void:

	var value = damage_package.dir * 250.0

	var modifier = Modifier.new_decay(value, 14.0, Modifier.Operator.ADD)

	modifier_tracker.add_modifier(modifier)




func _physics_process(delta: float) -> void:

	if not active:

		return

	var move_velocity = get_move_velocity()

	if entity.velocity == Vector2.ZERO and move_velocity != Vector2.ZERO:

		move_started.emit()

	if move_velocity == Vector2.ZERO and entity.velocity != Vector2.ZERO:

		move_ended.emit()

	entity.velocity = get_move_velocity()

	entity.move_and_slide()

	var move_dir = move_velocity.normalized()

	if move_dir != Vector2.ZERO:

		set_face_dir(move_dir)

	modifier_tracker.tick(delta)