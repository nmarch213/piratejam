extends CanvasLayer

func _ready():
	$MainMenuAnimation.play("menu_display_animation")

func _process(_delta):
	if Input.is_action_pressed("esc"): # skip to the end of the animation
		$MainMenuAnimation.advance(4.5)

func _on_how_to_play_button_pressed():
	pass # Replace with function body.
	#TODO: Make the "How To Play" section visible (also todo: make these nodes)

func _on_quit_button_pressed():
	$MainMenuAnimation.play("quit_animation")
	

func _on_begin_button_pressed():
	$MainMenuAnimation.play("begin_animation")

func _on_main_menu_animation_animation_finished(anim_name):
	match anim_name:
		"quit_animation":
			get_tree().quit()
		"begin_animation":
			get_tree().change_scene_to_file("res://main.tscn")
		#"menu_display_animation"
			#pass
