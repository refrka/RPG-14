class_name DelayCommand extends Command


@export var duration:= 1.0




func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("duration"):

		duration = data.duration

	var timer = Game.create_timer(duration)

	timer.timeout.connect(_on_timeout)

	result = Result.PENDING

	return result




func _on_timeout() -> void:

	result = Result.SUCCESS

	command_executed.emit()