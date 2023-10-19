extends Area2D

const float_number_scene = preload('res://scenes/float_number.tscn')
const experience_scene = preload('res://scenes/experience.tscn')

@onready var pivot: Node2D = $Pivot
@onready var damage_cooldown: Timer = $DamageCooldown

var target_hero: Node2D
var velocity = Vector2.ZERO
var move_speed = 30.0
var level = 1: set = _set_level
var life = 20


func _physics_process(delta: float) -> void:
	if target_hero == null:
		target_hero = get_tree().get_first_node_in_group('heroes')
	# chase hero
	var direction = global_position.direction_to(target_hero.global_position)
	velocity = direction * move_speed
	if not velocity.is_zero_approx():
		if velocity.x > 0:
			pivot.scale.x = 1
		elif velocity.x < 0:
			pivot.scale.x = -1
	global_position += velocity * delta
	# deal damage to hero
	for area in get_overlapping_areas():
		handle_collision(area)


func take_damage(damage_amount: int):
	var float_number = float_number_scene.instantiate()
	get_parent().add_child(float_number)
	float_number.show_at(global_position, damage_amount)
	life -= damage_amount
	if life <= 0:
		var experience = experience_scene.instantiate()
		experience.global_position = global_position
		get_tree().get_first_node_in_group('units').add_child.call_deferred(experience)
		queue_free()


func handle_collision(area: Area2D):
	if area.is_in_group('heroes'):
		if damage_cooldown.is_stopped():
			area.take_damage(level)
			damage_cooldown.start()


func _set_level(value: int):
	level = value
	life = value * 5 + 5
