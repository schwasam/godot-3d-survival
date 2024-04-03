extends ProgressBar
class_name NeedUIBar

@export var need_name: String

@onready var text: Label = %NeedText

func update_value(new_val: float, max_val: float) -> void:
	max_value = max_val
	value = new_val
	text.text = str(need_name, ": ", int(value), " / ", int(max_value))
