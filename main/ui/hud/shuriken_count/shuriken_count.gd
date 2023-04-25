class_name ShurikenCount
extends Label

export var fade_time: float = 0.5

func _ready() -> void:
	text = "%02d" % GlobalData.shuriken_count
	
	GlobalData.connect("shuriken_count_changed", self, "_on_shuriken_count_changed")
	get_node("%Timer").connect("timeout", self, "hide")

func _on_shuriken_count_changed(shuriken_count: int) -> void:
	text = "%02d" % shuriken_count
	show()
	get_node("%Timer").start()

func show() -> void:
	get_node("%Tween").stop_all()
	get_node("%Tween").interpolate_property(self, "modulate:a", null, 1.0, fade_time)
	get_node("%Tween").start()

func hide() -> void:
	get_node("%Tween").stop_all()
	get_node("%Tween").interpolate_property(self, "modulate:a", null, 0.0, fade_time)
	get_node("%Tween").start()
