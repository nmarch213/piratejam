extends Control

func _ready():
	$"../PauseContainer/PauseButton".pressed.connect(_on_pause_button_pressed)

func _on_pause_button_pressed():
	toggle_pause()
	
func _input(event):
	if event.is_action_pressed('esc'):
		toggle_pause()

func toggle_pause():
	unpause() if get_tree().paused else pause()

func pause():
	get_tree().paused = true
	show()

func unpause():
	var intu = $"../Tutorial".in_tutorial
	if not intu:
		get_tree().paused = false
		hide()
