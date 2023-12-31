extends Area2D

@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attack: Node2D = $Attack
@onready var progress_bar: ProgressBar = $ProgressBar

@export var default_weapon: WeaponData

var velocity = Vector2.ZERO
var move_speed = 80.0
var attack_direction = Vector2.RIGHT
var level = 1: set = _set_level
var experience = 0: set = _set_experience
var life = 25: set = _set_life
var weapons = {}


func _ready():
	acquire_weapon(default_weapon)


func acquire_weapon(weapon_data: WeaponData):
	if weapons.has(weapon_data):
		weapons[weapon_data].level += 1
	elif weapon_data.weapon_scene == null:
		# not a weapon
		print(weapon_data.get_description(self))
	else:
		var weapon = weapon_data.weapon_scene.instantiate()
		attack.add_child(weapon)
		weapons[weapon_data] = weapon


func get_weapon_level(weapon_data: WeaponData):
	if weapons.has(weapon_data):
		return weapons[weapon_data].level
	return 0


func _physics_process(delta: float) -> void:
	if velocity.is_zero_approx():
		animation_player.play('idle')
	else:
		animation_player.play('run')
	global_position += velocity * delta


func set_direction(direction: Vector2):
	if not direction.is_zero_approx():
		sprite.flip_h = direction.x < 0
	velocity = direction * move_speed


func set_attack_direction(direction: Vector2):
	if direction.is_zero_approx():
		return
	attack_direction = direction
	attack.rotation = attack_direction.angle()


func take_damage(damage_amount: int):
	life -= damage_amount


func get_max_experience():
	return level + 2


func get_max_life():
	return level * 15 + 20


func update_progress_bar():
	progress_bar.max_value = get_max_life()
	progress_bar.value = life


func _set_level(value):
	level = value
	life = get_max_life()
	update_progress_bar()


func _set_experience(value: int):
	experience = value
	var max_experience = get_max_experience()
	if experience >= max_experience:
		experience -= max_experience
		level += 1
		SignalBus.level_changed.emit(level)

	SignalBus.experience_changed.emit(experience, get_max_experience())


func _set_life(value: int):
	life = value
	update_progress_bar()
