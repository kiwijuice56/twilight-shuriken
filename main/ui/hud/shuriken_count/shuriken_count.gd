class_name ShurikenCount
extends Label

export var fade_time: float = 0.5

func _ready() -> void:
	text = "%02d" % GlobalData.shuriken_count
	
	GlobalData.connect("shuriken_count_changed", self, "_on_shuriken_count_changed")
	$Timer.connect("timeout", self, "set_transparency", [0.0])

func _on_shuriken_count_changed(shuriken_count: int) -> void:
	text = "%02d" % shuriken_count
	set_transparency(1.0)
	$Timer.start()

func set_transparency(alpha: float) -> void:
	$Tween.stop_all()
	$Tween.interpolate_property(self, "modulate:a", null, alpha, fade_time)
	$Tween.start()
