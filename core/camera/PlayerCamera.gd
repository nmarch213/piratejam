extends Camera2D

var dragging = false
var drag_start
var screen_start

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event.is_action('right click'):
		if event.is_pressed():
			dragging = true
			drag_start = event.position
			screen_start = position
		else:
			dragging = false
			drag_start = null
			screen_start = null	
	elif event is InputEventMouseMotion and dragging:
		position = zoom * (drag_start - event.position) + screen_start
	elif event.is_action_pressed('zoom in'):
		zoom.x += 0.25
		zoom.y += 0.25
	elif event.is_action_pressed('zoom out'):
		zoom.x -= 0.25
		zoom.y -= 0.25
	
		
