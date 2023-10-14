extends Area2D

var hero
var damage = 20


func _ready() -> void:
	area_entered.connect(deal_damage)


func _physics_process(delta: float) -> void:
	if hero == null:
		hero = get_tree().get_first_node_in_group('heroes')
	global_position = hero.global_position


func set_level(level):
	damage = 20 + level


func deal_damage(area: Area2D):
	area.take_damage(damage)
