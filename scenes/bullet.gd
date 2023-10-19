extends Area2D

var damage = 20


func _ready() -> void:
	area_entered.connect(deal_damage)


func set_level(level):
	pass


func deal_damage(area: Area2D):
	area.take_damage(damage)
