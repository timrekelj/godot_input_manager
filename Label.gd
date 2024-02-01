extends Label

var mouse_position: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	mouse_position = get_viewport().get_mouse_position()
	position = mouse_position
	position.y += 15

func _on_input_manager_raycast_enter(raycast_data):
	visible = true
	text = raycast_data.collider.on_right_click + "\n" + raycast_data.collider.on_left_click

func _on_input_manager_raycast_leave():
	visible = false
