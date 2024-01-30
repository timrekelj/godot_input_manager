extends StaticBody3D

@export var on_right_click = "right click action"
@export var on_left_click = "left click action"

func _on_input_manager_right_click_pressed(raycast_data):
	if (len(raycast_data) > 0 and raycast_data.collider == self):
		print("right click pressed on ball")

func _on_input_manager_left_click_pressed(raycast_data):
	if (len(raycast_data) > 0 and raycast_data.collider == self):
		print("left click pressed on ball")
