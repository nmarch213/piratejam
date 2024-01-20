extends Panel

@onready var game_manager = $"../../../Main/GameManager"
@onready var minutes_display = $MinutesDisplay
@onready var seconds_display = $SecondsDisplay


func _process(_delta):
	var minutes = fmod(game_manager.game_time, 3600) / 60	
	var seconds = fmod(game_manager.game_time, 60)
	
	minutes_display.text = "%02d:" % minutes
	seconds_display.text = "%02d" % seconds
