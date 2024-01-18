extends Node2D

@onready var quit_button: Button = $QuitButton


func _ready():
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	
func _on_quit_button_pressed():
	get_tree().quit()
