extends Area2D

@export var hero: Node2D


func _ready() -> void:
	area_entered.connect(pick)


func pick(area: Area2D):
	hero.experience += 1
	area.queue_free()
