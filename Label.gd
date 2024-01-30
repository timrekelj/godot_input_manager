extends Label

var mouse_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	mouse_position = get_viewport().get_mouse_position()
	position = mouse_position
	position.y += 15

func _on_input_manager_raycast_sent(raycast_data):
	# if raycast is not colliding or if the collider does not have the right attributes
	if (len(raycast_data) == 0 or "on_right_click" not in raycast_data.collider):
		visible = false
		return
		
	visible = true
	text = raycast_data.collider.on_right_click + "\n" + raycast_data.collider.on_left_click

