extends Node

var enemies_killed: int = 0 setget set_enemies_killed
var shuriken_count: int = 99 setget set_shuriken_count

signal shuriken_count_changed(val)
signal enemies_killed_changed(val)

func set_shuriken_count(val: int) -> void:
	shuriken_count = val
	emit_signal("shuriken_count_changed", shuriken_count)

func set_enemies_killed(val: int) -> void:
	enemies_killed = val
	emit_signal("enemies_killed_changed", enemies_killed)
