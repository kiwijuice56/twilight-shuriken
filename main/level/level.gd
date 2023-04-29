class_name Level
extends Spatial

var light_visible: bool = true

func _ready() -> void:
	$FlickerTimer.connect("timeout", self, "_on_flicker_timeout")

func _on_flicker_timeout() -> void:
	light_visible = not light_visible
	flicker(light_visible)

func flicker(on: bool) -> void:
	for light in $Lights.get_children():
		light.light_energy = 9000.01 if on else 0.0
	for enemy in $Enemies.get_children():
		enemy.visible = on
