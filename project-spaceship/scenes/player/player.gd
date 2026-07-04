extends CharacterBody3D


const SPEED: float = 20
const JUMP_VELOCITY: float = 4.5

var mouse_sensitivity: float = 0.01

var twist_input: float = 0
var pitch_input: float = 0
var cam_pitch_max: int = 60

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	var direction: Vector3
	var input: Vector3 = Vector3.ZERO
	
		#check wether mouse escaped
	if Input.is_action_just_pressed("Esc"):
		if Input.mouse_mode == 2:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	$TwistInput.rotate_y(twist_input)
	$TwistInput/PitchInput.rotate_z(pitch_input)
	$TwistInput/PitchInput.rotation.z = clamp($TwistInput/PitchInput.rotation.z, deg_to_rad(-cam_pitch_max), deg_to_rad(cam_pitch_max))
	
	twist_input = 0
	pitch_input = 0

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	input.x = Input.get_axis("backward", "forward")
	input.z = Input.get_axis("left", "right")

	direction = ($TwistInput.global_basis * input).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
