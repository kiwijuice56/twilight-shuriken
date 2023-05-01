class_name HitFlash
extends ColorRect

func _ready() -> void:
	visible = false
	$Timer.connect("timeout", self, "set_visible", [false])

func flash(flash_color: Color) -> void:
	material.set_shader_param("cover_color", flash_color)
	visible = true
	$Timer.start()
