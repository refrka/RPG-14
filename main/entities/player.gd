class_name Player extends Character





func get_component(script: Script) -> Component:

	script = PlayerMovementComponent if script == MovementComponent else script

	return super(script)