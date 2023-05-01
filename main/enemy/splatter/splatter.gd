# The 2D ink blotches that are painted onto the map when a blob collides
#
# Splatters are placed on a 4096x4096 viewport (corresponding to UVs, see PaintMesh)
# which is then wrapped onto the map mesh using a ViewportTexture
class_name Splatter
extends Sprite

export var rand_delay_limit: float = 0.8
export var rand_size_limit: float = 0.1
export var fade_time: float = 1.0

func _ready() -> void:
	scale *= 1.0 + rand_range(-rand_size_limit, rand_size_limit)
	material.set_shader_param("displacement", Vector2(randf(), randf()))
	material = material.duplicate()
	
	$BeginTimer.start($BeginTimer.wait_time * 1.0 + rand_range(-rand_delay_limit, rand_delay_limit))
	yield($BeginTimer, "timeout")
	$Tween.interpolate_property(material, "shader_param/threshold", null, 4.0, fade_time)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()
