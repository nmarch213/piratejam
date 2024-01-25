extends CanvasLayer

func _ready():
	$MainMenuAnimation.play("menu_display_animation")
	$MainMenuMusic.play()

func _process(_delta):
	if Input.is_action_pressed("esc"): # skip to the end of the animation
		$MainMenuAnimation.advance(100)

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
