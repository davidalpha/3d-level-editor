extends Label

@onready var game = get_node("/root/game/")
var counters: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for collectable in game.collectables:
		counters = str(collectable) + ": " + str(game.collectables[collectable])
		text = counters
