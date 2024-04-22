class_name animated extends Node

@onready var parent: Node = get_parent()
# Called when the node enters the scene tree for the first time.
var time: float
@export var y_bounce_amplitude: float
@export var y_bounce_frequency: float

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	parent.rotation.y += delta
	parent.position.y = sin(time*y_bounce_frequency)*y_bounce_amplitude
