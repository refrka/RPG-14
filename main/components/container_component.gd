class_name ContainerComponent extends InteractableComponent


enum ContainerState {

	CLOSED,

	OPEN,

	EMPTY,

	LOCKED

}

@export var open_audio: AudioStreamWAV

@export var close_audio: AudioStreamWAV

@export var locked:= false

@export var state_frames: Dictionary[ContainerState, int]


var container_state: ContainerState



func initialize(_entity: Entity) -> void:

	super(_entity)

	if locked:

		set_container_state(ContainerState.LOCKED)
		
	else:

		set_container_state(ContainerState.CLOSED)

	if state_frames.has(container_state):

		entity.body_sprite.frame = state_frames[container_state]




func can_interact() -> bool:

	return container_state != ContainerState.LOCKED and container_state != ContainerState.EMPTY




func start() -> void:

	UI.overlay_removed.connect(_on_overlay_removed)

	UI.show_container(entity)
	
	set_container_state(ContainerState.OPEN)

	if entity.audio_player:

		entity.audio_player.stream = open_audio

		entity.audio_player.play()




func end() -> void:

	UI.overlay_removed.disconnect(_on_overlay_removed)

	UI.hide_container()

	ended.emit()
	
	if entity.inventory.is_empty():

		set_container_state(ContainerState.EMPTY)

	else:
	
		set_container_state(ContainerState.CLOSED)

	if entity.audio_player:

		entity.audio_player.stream = close_audio

		entity.audio_player.play()

	


func set_container_state(state: ContainerState) -> void:

	container_state = state

	if state_frames.has(container_state):

		entity.body_sprite.frame = state_frames[container_state]



func _on_overlay_removed(overlay: Overlay) -> void:

	if overlay is ContainerOverlay:

		end()



func _on_death() -> void:

	pass