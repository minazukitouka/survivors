extends Node2D

@onready var timer: Timer = $Timer

@export var bullet_scene: PackedScene

var level = 1


func _ready() -> void:
	timer.timeout.connect(create_bullet)


func create_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.top_level = true
	add_child(bullet)
	bullet.set_level(level)
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
