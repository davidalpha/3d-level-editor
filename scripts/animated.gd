class_name animated extends Node

@onready var parent: Node = get_parent()
# always place as a direct child of the node you want to animate

## CONFIG

@export var spinning: bool
@export var spin_speed: int = 1

@export var bouncing: bool
@export var y_bounce_amplitude: float = 1
@export var y_bounce_frequency: float = 1


var time: float


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if spinning:
		parent.rotation.y += delta*spin_speed
		
	if bouncing:
		parent.position.y = sin(time*y_bounce_frequency)*y_bounce_amplitude
