extends 'res://scenes/bullet.gd'

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var free_timer: Timer = $FreeTimer

var level = 1
var move_speed = 300.0
var is_exploding = false
var is_splited = false


func _ready() -> void:
	super._ready()
	free_timer.timeout.connect(queue_free)


func set_level(value: int):
	level = value
	damage = max(0, level - 4) + 20
	if level >= 2:
		move_speed = 300.0 * 1.2


func _physics_process(delta: float) -> void:
	if is_exploding:
		return
	var velocity = move_speed * Vector2.RIGHT.rotated(global_rotation)
	global_position += velocity * delta


func deal_damage(area: Area2D):
	super.deal_damage(area)
	animation_player.play('explode')
	is_exploding = true
	print(level)
	if level >= 4 and not is_splited:
		perform_split()


func perform_split():
	var enemies = find_n_nearest_enemies(2)
	for enemy in enemies:
		create_bullet_to_enemy(enemy)


func create_bullet_to_enemy(enemy):
	var bullet = load('res://scenes/fireball.tscn').instantiate()
	bullet.top_level = true
	get_parent().add_child.call_deferred(bullet)
	bullet.set_level(level)
	bullet.is_splited = true
	bullet.global_position = global_position
	bullet.global_rotation = global_position.direction_to(enemy.global_position).angle()


func find_n_nearest_enemies(amount: int):
	var enemies = get_tree().get_nodes_in_group('enemies')
	# convert to [[enemy1, 500], [enemy2, 1000], ...]
	var enemy_distances = enemies.map(
		func (enemy):
			var distance = global_position.distance_squared_to(enemy.global_position)
			return [enemy, distance]
	)
	enemy_distances.sort_custom(
		func (a, b):
			return a[1] < b[1]
	)
	var nearest_enemies = enemy_distances.map(
		func (pair):
			return pair[0]
	)
	return nearest_enemies.slice(0, amount)
