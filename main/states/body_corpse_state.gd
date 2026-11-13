class_name BodyCorpseState extends BodyState


@export var corpse_frame:= -1


func enter() -> void:

	super()

	var animation_component = entity.get_component(AnimationComponent)

	if animation_component and animation_component.body_anim_player.is_playing():

		animation_component.body_anim_player.stop()

	entity.body_sprite.position.y = 0.0

	var movement_component = entity.get_component(MovementComponent)

	movement_component.deactivate()

	entity.hurtbox.deactivate()

	entity.add_component(CorpseComponent)

	entity.body_sprite.frame = corpse_frame