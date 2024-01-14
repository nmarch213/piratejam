extends Label

var max_length = 1

func _process(delta):
	text = str(SunlightManager.sunlight_banked)
	if text.length() > max_length:
		max_length = text.length()
		get_parent().get_parent().get_node("Bubble").transform.x.x = 1 + (.2 * max_length)
		position.x = 52 + max_length / 2
