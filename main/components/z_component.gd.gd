class_name ZComponent extends Component


@export var gravity:= -50


var floor_value:= 0.0

var z: float



func initialize(_entity: Entity) -> void:

	super(_entity)

	floor_value = entity.body_sprite.position.y




func is_on_floor() -> bool:

	return z == floor_value




