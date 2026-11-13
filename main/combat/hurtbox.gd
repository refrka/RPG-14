class_name Hurtbox extends Sensor


signal damage_package_received(damage_package: DamagePackage)



var damage_package_history: Array





func receive_damage_package(damage_package: DamagePackage) -> void:

	damage_package_history.append(damage_package)

	damage_package_received.emit(damage_package)