extends Node3D

@export var active_player: Node

# this script handles general input and is used for level configuration settings

func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_released("toggle interact with ui"):
		Input.MOUSE_MODE_VISIBLE
	
	if Input.is_action_just_released("toggle camera view"):
		active_player.toggle_camera_view()
