extends Node

@export var camera: Camera3D
var mouse_position: Vector2

signal raycast_sent(raycast_data)
signal left_click_pressed(raycast_data)
signal right_click_pressed(raycast_data)

# Called when the node enters the scene tree for the first time.
func _ready():
	if camera == null:
		camera = get_viewport().get_camera_3d()
		print("Camera:", camera)
	pass # Replace with function body.

func _process(_delta):
	# get mouse position
	mouse_position = get_viewport().get_mouse_position()
	get_raycast_data()
	raycast_sent.emit(get_raycast_data())
	

func _physics_process(_delta):
	pass

func _input(event):
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
		print("right mouse button clicked")
		right_click_pressed.emit(get_raycast_data())
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		print("left mouse button clicked")
		left_click_pressed.emit(get_raycast_data())
	pass

func get_raycast_data():
	var space_state = camera.get_world_3d().direct_space_state
	
	var origin = camera.project_ray_origin(mouse_position)
	var end = origin + camera.project_ray_normal(mouse_position) * 1000
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	
	var result = space_state.intersect_ray(query)
	return result

