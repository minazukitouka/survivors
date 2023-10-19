extends 'res://scenes/weapon.gd'


func create_bullet():
	var projectile_amount = 1
	if level >= 3:
		projectile_amount = 3
	var enemies = find_n_nearest_enemies(projectile_amount)
	for enemy in enemies:
		create_bullet_to_enemy(enemy)


func create_bullet_to_enemy(enemy):
	var bullet = bullet_scene.instantiate()
	bullet.top_level = true
	add_child(bullet)
	bullet.set_level(level)
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
