extends Node3D

var collectables: Dictionary
var player_scene = load("res://characters/player.tscn")
var player: Node

@export var floor_height = 0
@export var start_spawn: Node
var current_spawn: Node

# this script handles general input and is used for level configuration settings

func _ready():
	current_spawn = start_spawn
	player = player_scene.instantiate()
	player.position = current_spawn.position
	add_child(player)


func _process(delta):
	if Input.is_action_just_released("toggle interact with ui"):
		Input.MOUSE_MODE_VISIBLE
	
	if Input.is_action_just_released("toggle camera view"):
		player.toggle_camera_view()

func player_died():
	player.queue_free()
	player = player_scene.instantiate()
	player.position = current_spawn.position
	add_child(player)

func add_collectable(type):
	if collectables.find_key(str(type)):
		collectables[type] += 1
	else:
		collectables = {type: 1}
