class_name Effect extends Resource


enum EffectType {

	INSTANT,

	TICK,

	PASSIVE,

}


@export var effect_type: EffectType

@export var tick_rate:= 0.0


var target: Entity

var time_alive:= 0.0

var last_tick:= 0.0



func set_target(_target: Entity) -> void:

	target = _target



func apply() -> void:

	pass



func tick(delta: float) -> void:

	time_alive += delta

	if effect_type == EffectType.TICK:

		if time_alive - last_tick >= tick_rate:

			apply()

			last_tick = time_alive
