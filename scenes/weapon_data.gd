class_name WeaponData
extends Resource

@export var name: String
@export var weapon_scene: PackedScene
@export var descriptions: Array[String]


func get_description(hero):
	var level = hero.get_weapon_level(self)
	if level >= descriptions.size():
		return descriptions.back()
	return descriptions[level]
