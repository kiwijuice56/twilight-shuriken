class_name Enemy
extends Area

export var blob_count: int = 24
export var color: Color = Color(1.0, 0.0, 0.0)

const blob_scene: PackedScene = preload("res://main/enemy/blob/Blob.tscn")
const extra_blob_scene: PackedScene = preload("res://main/enemy/blob/ExtraBlobs.tscn")

func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(area: Area) -> void:
	#$CollisionShape.disabled = true
	if not area.get_parent() is Shuriken:
		return
	
	death(area.get_parent())

func death(projectile: Shuriken) -> void:
	$KillSoundSpawner.play_sound()
	var extra_blobs: CPUParticles = extra_blob_scene.instance()
	extra_blobs.mesh.material.albedo_color = color
	extra_blobs.translation = projectile.global_translation
	get_tree().get_root().add_child(extra_blobs)
	extra_blobs.emitting = true
	for _i in range(blob_count):
		var blob: Blob = blob_scene.instance()
		blob.color = color
		var wound_direction: Vector3 = (-1.0 if randf() < 0.5 else 1.0) * projectile.direction
		blob.initial_direction = wound_direction
		blob.translation = projectile.global_translation
		get_tree().get_root().add_child(blob)
	GlobalData.enemies_killed += 1
	GlobalData.ui.get_node("HUD/HitFlash").flash(color)
