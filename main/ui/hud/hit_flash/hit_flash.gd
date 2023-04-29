class_name HitFlash
extends ColorRect

func _ready() -> void:
	visible = false
	GlobalData.connect("enemies_killed_changed", self, "_on_enemies_killed_changed")
	$Timer.connect("timeout", self, "set_visible", [false])

func _on_enemies_killed_changed(_val: int) -> void:
	visible = true
	$Timer.start()
