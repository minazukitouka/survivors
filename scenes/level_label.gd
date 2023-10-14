extends Label


func _ready() -> void:
	SignalBus.level_changed.connect(update_text)


func update_text(level):
	text = "Level: {0}".format([level])
