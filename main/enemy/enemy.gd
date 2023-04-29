class_name Enemy
extends Area

export var blob_count: int = 24

const blob_scene: PackedScene = preload("res://main/enemy/blob/Blob.tscn")
const extra_blob_scene: PackedScene = preload("res://main/enemy/blob/ExtraBlobs.tscn")

func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(_area: Area) -> void:
	#$CollisionShape.disabled = true
	death()

func death() -> void:
	$KillSoundSpawner.play_sound()
	var extra_blobs: CPUParticles = extra_blob_scene.instance()
	extra_blobs.translation = $BlobSpawn.global_translation
	get_tree().get_root().add_child(extra_blobs)
	extra_blobs.emitting = true
	for _i in range(blob_count):
		var blob: Blob = blob_scene.instance()
		blob.initial_direction = Vector3.UP
		blob.translation = $BlobSpawn.global_translation
		get_tree().get_root().add_child(blob)
	GlobalData.enemies_killed += 1
