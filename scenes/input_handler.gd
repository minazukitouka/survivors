extends Node

@export var hero: Node2D


func _physics_process(delta: float) -> void:
	var run_input = Input.get_vector('run_left', 'run_right', 'run_up', 'run_down')
	hero.set_direction(run_input)

	var attack_input = Input.get_vector('attack_left', 'attack_right', 'attack_up', 'attack_down')
	hero.set_attack_direction(attack_input)
