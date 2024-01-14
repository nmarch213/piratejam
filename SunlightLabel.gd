extends Label

func _process(delta):
	var new_text = str(SunlightManager.sunlight_banked)
	var length_change = new_text.length() - text.length()
	if length_change > 0:
		get_parent().get_node("Bubble").transform.x.x += (.2 * length_change)
		#position.x += (position.x * (1 + .1 * length_change))
	text = new_text
