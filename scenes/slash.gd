extends 'res://scenes/bullet.gd'

var hero


func _physics_process(delta: float) -> void:
	if hero == null:
		hero = get_tree().get_first_node_in_group('heroes')
	global_position = hero.global_position


func set_level(level):
	damage = 20 + level
