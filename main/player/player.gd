class_name Player
extends Spatial

export var look_up_limit: float = deg2rad(70)

var shuriken_scene: PackedScene = preload("res://main/player/shuriken/Shuriken.tscn")

onready var cam: Camera = $Pivot/Camera
onready var throw_spawner: SoundSpawner = $ThrowSoundSpawner

func _ready() -> void:
	randomize()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * GlobalSettings.mouse_sensitivity)
		cam.rotate_x(-event.relative.y * GlobalSettings.mouse_sensitivity)
		cam.rotation.x = clamp(cam.rotation.x, -look_up_limit, look_up_limit)
	if event.is_action_pressed("throw", false):
		throw_shuriken()

func throw_shuriken() -> void:
	if GlobalData.shuriken_count <= 0:
		return
	GlobalData.shuriken_count -= 1
	
	var new_shuriken: Shuriken = shuriken_scene.instance()
	var spawn: Position3D = get_node("Pivot/Camera/ShurikenSpawn" + ("A" if randf() < 0.5 else "B"))
	new_shuriken.direction = ($Pivot/Camera/Target.global_transform.origin - spawn.global_transform.origin).normalized()
	new_shuriken.desired_direction = -$Pivot/Camera.global_transform.basis.z
	new_shuriken.rotation_degrees = rotation_degrees
	new_shuriken.transform.origin = spawn.global_transform.origin
	
	get_tree().get_root().get_child(0).add_child(new_shuriken)
	
	new_shuriken.randomize_apperance()
	throw_spawner.play_sound()
