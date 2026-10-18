extends Camera2D

@export var pan_speed: float = 300.0

func _process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down")

	position += direction * pan_speed * delta / zoom.x

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("camera_drag"):
			position -= event.relative / zoom.x
			get_viewport().set_input_as_handled()
		return

	if event.is_action_pressed("camera_zoom_in"):
		change_zoom(1.2)
	elif event.is_action_pressed("camera_zoom_out"):
		change_zoom(1.0 / 1.2)
	else:
		return

	get_viewport().set_input_as_handled()


func change_zoom(factor: float) -> void:
#	var level: float = clampf(zoom.x * factor, 0.05, 20.0)
#	zoom = Vector2.ONE * level
	zoom *= factor
	zoom *= factor
