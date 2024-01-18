extends Node2D

@onready var quit_button: Button = $QuitButton
@onready var restart_button = $RestartButton


func _ready():
	quit_button.pressed.connect(_on_quit_button_pressed)
	restart_button.pressed.connect(_on_restart_button_pressed)
	
	
func _on_quit_button_pressed():
	get_tree().quit()
	
func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	SunlightManager.sunlight_banked = SunlightManager.starting_sunlight_banked
