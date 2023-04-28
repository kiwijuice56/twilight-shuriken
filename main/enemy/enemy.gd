class_name Enemy
extends Area

export var blob_count: int = 24

var blob_scene: PackedScene = preload("res://main/enemy/Blob.tscn")

func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(area: Area) -> void:
	#$CollisionShape.disabled = true
	death()

func death() -> void:
	for i in range(blob_count):
		var blob: Blob = blob_scene.instance()
		blob.direction = Vector3.UP
		blob.translation = $BlobSpawn.global_translation
		get_tree().get_root().add_child(blob)
		
