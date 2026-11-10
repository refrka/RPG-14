class_name MovementComponent extends Component



signal move_started

signal move_ended

signal face_dir_changed(dir: Vector2)



var face_dir: Vector2



func get_move_dir() -> Vector2:

	return Vector2.ZERO



func get_move_velocity() -> Vector2:

	return Vector2.ZERO



func get_gravity() -> float:

	return 0.0




func set_face_dir(dir: Vector2) -> void:

	if dir == face_dir:

		return

	face_dir = dir

	face_dir_changed.emit(dir)




func _physics_process(_delta: float) -> void:

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