extends Sprite2D

func _on_sunlight_label_sunlight_text_max_changed(length):
	transform.x.x = 1 + (.2 * length)
