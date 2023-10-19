extends CenterContainer

@onready var level_option_1: Button = $VBoxContainer/LevelOption1
@onready var level_option_2: Button = $VBoxContainer/LevelOption2
@onready var level_option_3: Button = $VBoxContainer/LevelOption3
@onready var level_option_4: Button = $VBoxContainer/LevelOption4

@export var available_weapons: Array[WeaponData]

var options


func _ready() -> void:
	SignalBus.level_changed.connect(pause_and_show_menu)
	level_option_1.pressed.connect(level_up.bind(0))
	level_option_2.pressed.connect(level_up.bind(1))
	level_option_3.pressed.connect(level_up.bind(2))
	level_option_4.pressed.connect(level_up.bind(3))


func pause_and_show_menu(_level):
	prepare_options()
	visible = true
	level_option_1.grab_focus()
	get_tree().paused = true


func level_up(index: int):
	var hero = get_hero()
	var weapon_data = options[index]
	hero.acquire_weapon(weapon_data)
	resume()


func resume():
	visible = false
	get_tree().paused = false


func prepare_options():
	options = available_weapons.duplicate()
	options.shuffle()
	options = options.slice(0, 4)

	var hero = get_hero()

	level_option_1.text = options[0].get_description(hero)
	level_option_2.text = options[1].get_description(hero)
	level_option_3.text = options[2].get_description(hero)
	level_option_4.text = options[3].get_description(hero)


func get_hero():
	return get_tree().get_first_node_in_group('heroes')
