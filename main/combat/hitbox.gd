class_name Hitbox extends Sensor



var hit_list: Array

var attack_entry: AttackEntry




func initialize(_entity: Entity) -> void:

	super(_entity)

	sensor_entered.connect(_on_sensor_entered)

	sensor_exited.connect(_on_sensor_exited)





func clear() -> void:

	hit_list.clear()




func set_attack_entry(_attack_entry: AttackEntry) -> void:

	attack_entry = _attack_entry




func hit(hurtbox: Hurtbox) -> void:

	if not hit_list.has(hurtbox):

		hit_list.append(hurtbox)

		var damage_package = generate_damage_package()

		damage_package.dir = entity.direction_to_entity(hurtbox.entity)

		hurtbox.receive_damage_package(damage_package)





func generate_damage_package() -> DamagePackage:

	var damage_package = DamagePackage.new()
	
	damage_package.source_entity = entity

	damage_package.amount = attack_entry.base_damage

	return damage_package






func _on_sensor_entered(sensor: Sensor) -> void:

	if sensor is Hurtbox and not hit_list.has(sensor) and sensor.active:

		hit(sensor)



func _on_sensor_exited(sensor: Sensor) -> void:

	pass