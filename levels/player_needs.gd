extends Node3D

@export var no_food_health_decay: float
@export var no_water_health_decay: float

@onready var health: Need = %Health
@onready var food: Need = %Food
@onready var water: Need = %Water
@onready var exhaustion: Need = %Exhaustion

var game_over: bool = false

func _ready() -> void:
	health.value = health.start_value
	food.value = food.start_value
	water.value = water.start_value
	exhaustion.value = exhaustion.start_value

func _process(delta: float) -> void:
	if game_over:
		return

	food.subtract(food.decay_rate * delta)
	water.subtract(water.decay_rate * delta)
	exhaustion.add(exhaustion.regen_rate * delta)

	if food.value <= 0:
		health.subtract(no_food_health_decay * delta)

	if water.value <= 0:
		health.subtract(no_water_health_decay * delta)

	if health.value <= 0:
		game_over = true
		print("You died!")

	health.update_ui_bar()
	food.update_ui_bar()
	water.update_ui_bar()
	exhaustion.update_ui_bar()
