class_name Splatter
extends Sprite

export var rand_delay_limit: float = 0.8
export var rand_size_limit: float = 0.1
export var fade_time: float = 1.0

func _ready() -> void:
	scale *= 1.0 + rand_range(-rand_size_limit, rand_size_limit)
	# The fade out doesn't look very good, keeping it to toggle later just in case
	$BeginTimer.start($BeginTimer.wait_time * 1.0 + rand_range(-rand_delay_limit, rand_delay_limit))
	yield($BeginTimer, "timeout")
	$Tween.interpolate_property(self, "scale", null, Vector2(), fade_time)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()
