extends Control

func _ready():
	$"../PauseContainer/PauseButton".pressed.connect(_on_pause_button_pressed)

func _on_pause_button_pressed():
	toggle_pause()
	
func _input(event):
	if event.is_action_pressed('esc'):
		toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		show()
	else:
		hide()
