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

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera.rotation_degrees.x += event.relative.y * -look_sensitivity
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, min_x_rotation, max_x_rotation)
		camera.rotation_degrees.y += event.relative.x * -look_sensitivity

func _process(delta: float) -> void:
	camera.position = head.global_position

func _physics_process(delta: float) -> void:
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	velocity.x = input.x * move_speed
	velocity.z = input.y * move_speed
	move_and_slide()
