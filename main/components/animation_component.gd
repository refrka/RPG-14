class_name AnimationComponent extends Component



@export var body_anim_player: AnimationPlayer

@export var combat_anim_player: AnimationPlayer

var movement_component: MovementComponent




func initialize(_entity: Entity) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.face_dir_changed.connect(_on_face_dir_changed)




func play_body_anim(anim_name: String) -> void:

	if body_anim_player.has_animation(anim_name):

		body_anim_player.play(anim_name)



func play_combat_anim(anim_name: String) -> void:

	if combat_anim_player.has_animation(anim_name):

		combat_anim_player.play(anim_name)



func _on_face_dir_changed(dir: Vector2) -> void:

	entity.body_sprite.flip_h = dir.x < 0.0