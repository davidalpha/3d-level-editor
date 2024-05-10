extends CharacterBody3D

@onready var game = get_node("/root/game/")

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var current_camera_view: int = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	$CameraPivot1P/Camera3D.current = true

func _physics_process(delta):
	
	if self.position.y < (game.floor_height -2):
		game.player_died()
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		var input_dir = Input.get_vector("player_left", "player_right", "player_up", "player_down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

		if direction:
			velocity.x = direction.x * SPEED/2
			velocity.z = direction.z * SPEED/2	
		
	# Handle Jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# handle walljump	
	if Input.is_action_just_pressed("player_jump") and is_on_wall():
			#velocity.y = JUMP_VELOCITY
			var collider = get_last_slide_collision()
			var collider_normal = collider.get_normal()
			print(collider_normal)
			velocity.x = collider_normal.x*SPEED
			velocity.z = collider_normal.z*SPEED
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor():
		var input_dir = Input.get_vector("player_left", "player_right", "player_up", "player_down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / $CameraPivot3P.sensitivity
		
		$CameraPivot3P/Camera3D.rotation.x -= event.relative.y / $CameraPivot3P.sensitivity
		$CameraPivot3P/Camera3D.rotation.x = clamp($CameraPivot3P/Camera3D.rotation.x, deg_to_rad(-45), deg_to_rad(90))
		
		$CameraPivot1P/Camera3D.rotation.x -= event.relative.y / $CameraPivot3P.sensitivity
		$CameraPivot1P/Camera3D.rotation.x = clamp($CameraPivot1P/Camera3D.rotation.x, deg_to_rad(-45), deg_to_rad(90))
		
func toggle_camera_view():
	if $CameraPivot3P/Camera3D.current:
		$CameraPivot3P/Camera3D.current = !$CameraPivot3P/Camera3D.current
		return	
	if $CameraPivot1P/Camera3D.current:
		$CameraPivot1P/Camera3D.current = !$CameraPivot1P/Camera3D.current
		return


func _on_area_3d_area_entered(area):
	if area.is_in_group("spawns"):
		game.current_spawn = area

	if area.is_in_group("collectables"):
		game.add_collectable(area.type)
		area.queue_free()

