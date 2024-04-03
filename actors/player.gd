extends CharacterBody3D

var head: Node3D
var camera: Camera3D

var move_speed: float = 5.0
var jump_force: float = 5.0
var gravity: float = 9.0

var look_sensitivity: float = 0.5
var min_x_rotation: float = -85.0
var max_x_rotation: float = 85.0
var mouse_direction: Vector2

func _ready() -> void:
	head = %Head
	camera = %Camera
	remove_child(camera)
	get_node("/root/Main").add_child.call_deferred(camera)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera.rotation_degrees.x += event.relative.y * -look_sensitivity
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, min_x_rotation, max_x_rotation)
		camera.rotation_degrees.y += event.relative.x * -look_sensitivity

func _process(_delta: float) -> void:
	camera.position = head.global_position

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	if not is_on_floor():
		velocity.y -= gravity * delta

	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = camera.basis.z * input.y + camera.basis.x * input.x
	direction.y = 0
	direction = direction.normalized()

	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed

	move_and_slide()
