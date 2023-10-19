extends Path2D

@onready var timer: Timer = $Timer
@onready var spawn_position: PathFollow2D = $SpawnPosition

@export var enemy_scenes: Array[PackedScene]
@export var node_to_spawn: Node2D

var level = 1.0
var next_enemy_index = 0
var spawn_count = 5
var max_spawn_count = 20
var offset_from_edge = 50


func _ready() -> void:
	update_curve()
	timer.timeout.connect(spawn)


func update_curve():
	var width = ProjectSettings.get_setting('display/window/size/viewport_width')
	var height = ProjectSettings.get_setting('display/window/size/viewport_height')
	var x = width / 2 + offset_from_edge
	var y = height / 2 + offset_from_edge
	curve.clear_points()
	curve.add_point(Vector2(-x, -y))
	curve.add_point(Vector2(x, -y))
	curve.add_point(Vector2(x, y))
	curve.add_point(Vector2(-x, y))
	curve.add_point(Vector2(-x, -y))


func spawn() -> void:
	var enemy_scene = enemy_scenes[next_enemy_index]
	for i in spawn_count:
		spawn_position.progress_ratio = float(i) / spawn_count
		var enemy = enemy_scene.instantiate()
		enemy.global_position = spawn_position.global_position
		enemy.level = int(float(level))
		node_to_spawn.add_child(enemy)

	next_enemy_index = (next_enemy_index + 1) % enemy_scenes.size()
	spawn_count = min(spawn_count + 1, max_spawn_count)
	level += 0.1
