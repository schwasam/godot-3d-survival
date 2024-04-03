extends Node3D

@export var day_length: float = 20.0
@export var start_time: float = 0.3

@export var sun_color: Gradient
@export var sun_intensity: Curve

@export var moon_color: Gradient
@export var moon_intensity: Curve

@export var sky_top_color: Gradient
@export var sky_horizon_color: Gradient

var time: float
var time_rate: float

var sun: DirectionalLight3D
var moon: DirectionalLight3D
var environment: WorldEnvironment

func _ready() -> void:
	time = start_time
	time_rate = 1.0 / day_length

	sun = %Sun
	moon = %Moon
	environment = %WorldEnvironment

func _process(delta: float) -> void:
	time += time_rate * delta

	if time >= 1.0:
		time = 0.0

	sun.rotation_degrees.x = time * 360 + 90
	sun.light_color = sun_color.sample(time)
	sun.light_energy = sun_intensity.sample(time)
	sun.visible = sun.light_energy > 0

	moon.rotation_degrees.x = time * 360 + 270
	moon.light_color = moon_color.sample(time)
	moon.light_energy = moon_intensity.sample(time)
	moon.visible = moon.light_energy > 0

	environment.environment.sky.sky_material.set("sky_top_color", sky_top_color.sample(time))
	environment.environment.sky.sky_material.set("sky_horizon_color", sky_horizon_color.sample(time))
	environment.environment.sky.sky_material.set("ground_bottom_color", sky_horizon_color.sample(time))
	environment.environment.sky.sky_material.set("ground_horizon_color", sky_horizon_color.sample(time))
