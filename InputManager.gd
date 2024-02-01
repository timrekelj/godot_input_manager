extends Node

@export var camera: Camera3D
var mouse_position: Vector2

var current_interactable

signal raycast_enter(raycast_data)
signal raycast_leave()
signal left_click_pressed(raycast_data)
signal right_click_pressed(raycast_data)

# Called when the node enters the scene tree for the first time.
func _ready():
	if camera == null:
		camera = get_viewport().get_camera_3d()
		print("Camera:", camera)

func _process(_delta):
	# get mouse position
	mouse_position = get_viewport().get_mouse_position()
	var raycast = get_raycast_data()

	# leave interactable
	if (
		(len(raycast) == 0 or raycast.collider not in get_tree().get_nodes_in_group("Interactables")) and
		current_interactable != null
	):
		raycast_leave.emit()
		print("raycast left")
		current_interactable = null
		return
	
	# enter or swithc interactable
	if (
		len(raycast) > 0 and
		raycast.collider in get_tree().get_nodes_in_group("Interactables") and
		(current_interactable == null or # enter interactable 
		(current_interactable != raycast.collider and current_interactable != null)) # switch interactable
	):
		current_interactable = raycast.collider
		raycast_enter.emit(raycast)
		print("raycast entered interactable")
		return

func _input(event):
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
		print("right mouse button clicked")
		right_click_pressed.emit(get_raycast_data())
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		print("left mouse button clicked")
		left_click_pressed.emit(get_raycast_data())


func get_raycast_data():
	var space_state = camera.get_world_3d().direct_space_state
	var origin = camera.project_ray_origin(mouse_position)
	var end = origin + camera.project_ray_normal(mouse_position) * 1000
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	
	var result = space_state.intersect_ray(query)
	return result

