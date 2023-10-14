extends CenterContainer

@onready var level_option_1: Button = $VBoxContainer/LevelOption1
@onready var level_option_2: Button = $VBoxContainer/LevelOption2
@onready var level_option_3: Button = $VBoxContainer/LevelOption3
@onready var level_option_4: Button = $VBoxContainer/LevelOption4


func _ready() -> void:
	SignalBus.level_changed.connect(pause_and_show_menu)
	level_option_1.pressed.connect(resume)
	level_option_2.pressed.connect(resume)
	level_option_3.pressed.connect(resume)
	level_option_4.pressed.connect(resume)


func pause_and_show_menu(_level):
	visible = true
	get_tree().paused = true


func resume():
	visible = false
	get_tree().paused = false
