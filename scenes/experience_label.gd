extends Label


func _ready() -> void:
	SignalBus.experience_changed.connect(update_text)


func update_text(exp, max_exp):
	text = "Exp: {0}/{1}".format([exp, max_exp])
