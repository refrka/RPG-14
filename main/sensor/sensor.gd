class_name Sensor extends Area2D


signal entity_entered(_entity: Entity)

signal entity_exited(_entity: Entity)

signal sensor_entered(sensor: Sensor)

signal sensor_exited(sensor: Sensor)



var active:= false

var entity: Entity



var entities: Array

var sensors: Array









func initialize(_entity: Entity) -> void:

	entity = _entity





func connect_signals() -> void:

	body_entered.connect(_on_body_entered)

	body_exited.connect(_on_body_exited)

	area_entered.connect(_on_area_entered)

	area_exited.connect(_on_area_exited)




func disconnect_signals() -> void:

	body_entered.disconnect(_on_body_entered)

	body_exited.disconnect(_on_body_exited)

	area_entered.disconnect(_on_area_entered)

	area_exited.disconnect(_on_area_exited)









func activate() -> void:

	active = true

	connect_signals()




func deactivate() -> void:

	active = false

	disconnect_signals()

	entities.clear()

	sensors.clear()










func _on_body_entered(body: PhysicsBody2D) -> void:

	if not active or body == entity:

		return

	if body is Entity and not entities.has(body):

		entities.append(body)

		entity_entered.emit(body)


	

func _on_body_exited(body: PhysicsBody2D) -> void:

	if not active:

		return

	if entities.has(body):

		entities.erase(body)

		entity_exited.emit(body)




func _on_area_entered(area: Area2D) -> void:

	if not active:

		return

	if area is Sensor and not sensors.has(area) and not area.entity == entity:

		sensors.append(area)

		sensor_entered.emit(area)

	


func _on_area_exited(area: Area2D) -> void:

	if not active:

		return

	if sensors.has(area):

		sensors.erase(area)

		sensor_exited.emit(area)
