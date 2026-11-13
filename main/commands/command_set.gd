class_name CommandSet extends Resource


signal all_commands_executed


@export var commands: Array[Command]



var current_index:= 0

var data:= {}





func execute_all(_data:= {}) -> void:

	data = _data

	execute_index(0)



func next_command() -> void:

	var next_index = current_index + 1

	if is_index_valid(next_index):

		execute_index(next_index)

	else:

		all_commands_executed.emit()



func get_command(index: int) -> Command:

	if commands.size() - 1 >= index:

		return commands[index]

	return null



func is_index_valid(index: int) -> bool:

	return commands.size() - 1 >= index




func execute_index(index: int) -> void:

	current_index = index

	var command = get_command(current_index)

	match command.execute(data):

		Command.Result.SUCCESS:

			next_command()

		Command.Result.PENDING:

			command.command_executed.connect(_on_command_executed.bind(command), CONNECT_ONE_SHOT)




func _on_command_executed(_command: Command) -> void:

	next_command()