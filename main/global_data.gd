extends Node

var shuriken_count: int = 99 setget set_shuriken_count

signal shuriken_count_changed(val)

func set_shuriken_count(val: int) -> void:
	shuriken_count = val
	emit_signal("shuriken_count_changed", shuriken_count)
