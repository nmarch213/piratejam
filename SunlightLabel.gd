extends Label

var max_length = 1
signal sunlight_text_max_changed(length)

func _process(_delta):
	text = str(SunlightManager.sunlight_banked)
	if text.length() > max_length:
		max_length = text.length()
		sunlight_text_max_changed.emit(max_length)
		position.x = 52 + max_length / 2
