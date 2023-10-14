extends Node2D

@onready var label: Label = $Label


func show_at(position: Vector2, value: int):
	top_level = true
	global_position = position
	label.text = str(value)
