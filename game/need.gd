extends Node
class_name Need

@export var max_value: float
@export var start_value: float
@export var regen_rate: float
@export var decay_rate: float
@export var ui_bar: NeedUIBar

var value: float

func add(amount: float) -> void:
	value += amount

	if value > max_value:
		value = max_value

func subtract(amount: float) -> void:
	value -= amount

	if value < 0:
		value = 0

func update_ui_bar() -> void:
	ui_bar.update_value(value, max_value)
