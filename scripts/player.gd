extends CharacterBody3D

@onready var camera_3d: Camera3D = $Camera3D
@onready var ray_cast_3d: RayCast3D = $Camera3D/RayCast3D

const SPEED = 12.0
const JUMP_VELOCITY = 8
var senstivity = 0.002
const GRAVITY = Vector3(0,-14,0)


func _ready():
	ray_cast_3d.enabled = true
	print("Ray start:", ray_cast_3d.global_position)
	print("Ray end:", ray_cast_3d.to_global(ray_cast_3d.target_position))
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y = rotation.y - event.relative.x * senstivity
		camera_3d.rotation.x = camera_3d.rotation.x - event.relative.y * senstivity
		camera_3d.rotation.x = clamp(camera_3d.rotation.x ,deg_to_rad(-70), deg_to_rad(80))
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0
		velocity.z = 0

	if Input.is_action_just_pressed("left_click"):
		if ray_cast_3d.is_colliding():
			if ray_cast_3d.get_collider().has_method("destroy_block"):
				ray_cast_3d.get_collider().destroy_block(ray_cast_3d.get_collision_point()-ray_cast_3d.get_collision_normal())
	var block_idx =5 # wood
	if Input.is_action_just_pressed("right_click"):
		if ray_cast_3d.is_colliding():
			if ray_cast_3d.get_collider().has_method("place_block"):
				ray_cast_3d.get_collider().place_block(ray_cast_3d.get_collision_point()+ray_cast_3d.get_collision_normal(),block_idx)

	move_and_slide()
