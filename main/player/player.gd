class_name Player
extends Spatial

export var look_up_limit: float = deg2rad(70)

const shuriken_scene: PackedScene = preload("res://main/player/shuriken/Shuriken.tscn")

onready var cam: Camera = $Pivot/Camera

func _ready() -> void:
	GlobalData.connect("enemies_killed_changed", self, "_on_enemies_killed_changed")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * GlobalSettings.mouse_sensitivity)
		cam.rotate_x(-event.relative.y * GlobalSettings.mouse_sensitivity)
		cam.rotation.x = clamp(cam.rotation.x, -look_up_limit, look_up_limit)
	if event.is_action_pressed("throw", false):
		throw_shuriken()

func _on_enemies_killed_changed(_val: int) -> void:
	cam.add_trauma(0.115)

func throw_shuriken() -> void:
	if GlobalData.shuriken_count <= 0:
		return
	GlobalData.shuriken_count -= 1
	
	var new_shuriken: Shuriken = shuriken_scene.instance()
	var spawn: Position3D = cam.get_node("ShurikenSpawn" + ("A" if randf() < 0.5 else "B"))
	new_shuriken.direction = (cam.get_node("Target").global_transform.origin - spawn.global_transform.origin).normalized()
	new_shuriken.desired_direction = -cam.global_transform.basis.z
	new_shuriken.rotation_degrees = rotation_degrees
	new_shuriken.transform.origin = spawn.global_transform.origin
	
	get_tree().get_root().get_child(0).add_child(new_shuriken)
	
	new_shuriken.randomize_apperance()
	$ThrowSoundSpawner.play_sound()
