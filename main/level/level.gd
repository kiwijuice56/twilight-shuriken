class_name Level
extends Spatial

var is_on: bool = true

func _ready() -> void:
	$FlickerTimer.connect("timeout", self, "_on_flicker_timeout")

func _on_flicker_timeout() -> void:
	is_on = not is_on
	flicker(is_on)

func flicker(on: bool) -> void:
	for light in $Lights.get_children():
		light.light_energy = 9000.01 if on else 0.0
	for enemy in $Enemies.get_children():
		enemy.visible = on
