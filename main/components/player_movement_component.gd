class_name PlayerMovementComponent extends MovementComponent





var move_left_pressed:= false

var move_right_pressed:= false

var move_up_pressed:= false

var move_down_pressed:= false



func get_move_dir() -> Vector2:

	var input_dir = Vector2.ZERO

	if move_left_pressed:

		input_dir.x -= 1

	if move_right_pressed:

		input_dir.x += 1

	if move_up_pressed:

		input_dir.y -= 1

	if move_down_pressed:

		input_dir.y += 1

	return input_dir.normalized()





func get_move_velocity() -> Vector2:

	return get_move_dir() * 50.0






func _unhandled_input(event: InputEvent) -> void:

	if event.is_action("move_left"):

		move_left_pressed = event.is_pressed()

	if event.is_action("move_right"):

		move_right_pressed = event.is_pressed()

	if event.is_action("move_up"):

		move_up_pressed = event.is_pressed()

	if event.is_action("move_down"):

		move_down_pressed = event.is_pressed()