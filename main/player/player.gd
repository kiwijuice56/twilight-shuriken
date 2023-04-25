class_name Player
extends Spatial

export var look_up_limit: float = rad2deg(70)

var shuriken_scene: PackedScene = preload("res://main/player/shuriken/Shuriken.tscn")

onready var cam: Camera = $Pivot/Camera
onready var throw_spawner: SoundSpawner = $ThrowSoundSpawner

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * Settings.mouse_sensitivity)
		cam.rotate_x(-event.relative.y * Settings.mouse_sensitivity)
		cam.rotation.x = clamp(cam.rotation.x, -look_up_limit, look_up_limit)
	if event.is_action_pressed("throw", false):
		throw_shuriken()

func throw_shuriken() -> void:
	var new_shuriken: Bullet = shuriken_scene.instance()
	get_tree().get_root().get_child(0).add_child(new_shuriken)
	new_shuriken.direction = -cam.global_transform.basis.z
	new_shuriken.rotation_degrees = rotation_degrees
	new_shuriken.global_transform.origin = global_transform.origin
	new_shuriken.randomize_apperance()
	
	throw_spawner.play_sound()
