class_name PauseMenu
extends Submenu

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
