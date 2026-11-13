class_name Pickup extends Entity


@export var sensor: Sensor

@export var stack: ItemStack

var pickup_enabled:= false

var float_to_entity: Entity

var animation_component: AnimationComponent




func initialize() -> bool:

	if not super():

		return false

	sensor.initialize(self)

	sensor.entity_entered.connect(_on_entity_entered_sensor)

	animation_component = get_component(AnimationComponent)

	animation_component.body_anim_player.animation_finished.connect(_on_animation_finished)

	audio_player.finished.connect(_on_audio_finished)

	return true




func activate() -> void:

	super()

	sensor.activate()

	animation_component.play_body_anim("drop")



func deactivate() -> void:

	super()

	sensor.deactivate()





func _on_entity_entered_sensor(entity: Entity) -> void:

	if pickup_enabled:

		float_to_entity = entity



func _process(delta: float) -> void:

	if not active:

		return

	if float_to_entity:

		var target_position = float_to_entity.center_marker.global_position

		global_position = (global_position + center_marker.position).move_toward(target_position, 80.0 * delta)

		var distance = center_marker.global_position.distance_to(target_position)

		if distance <= 10.0:

			float_to_entity.inventory.add_item_stack(stack)

			if not audio_player.has_stream_playback():

				print("play")

				audio_player.play()





static func create(_stack: ItemStack) -> Pickup:

	var pickup = load("res://main/entities/pickup.tscn").instantiate()

	pickup.stack = _stack

	pickup.body_sprite.texture = _stack.item.icon_texture

	pickup.body_sprite.offset.y = -_stack.item.icon_texture.get_size().y / 2

	return pickup





func _on_animation_finished(anim_name: String) -> void:

	if anim_name == "drop":

		pickup_enabled = true

		if not sensor.entities.is_empty():

			float_to_entity = sensor.entities[0]

		animation_component.body_anim_player.play("float")




func _on_audio_finished() -> void:

	print("finished")

	float_to_entity = null

	queue_free.call_deferred()