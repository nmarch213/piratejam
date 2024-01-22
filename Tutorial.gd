extends CanvasLayer

var tutorial_step = 0
@export var in_tutorial = false

var TUTORIAL_ENABLED = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$TutorialDisplay.hide()
	if TUTORIAL_ENABLED:
		$TutorialTimer.timeout.connect(_on_tutorial_timer_timeout)

func _on_tutorial_timer_timeout():
	if !$TutorialDisplay.visible:
		match tutorial_step:
			0:
				if not SunlightManager.spent_any:
					in_tutorial = true
					$TutorialDisplay/WillySmug.show()
					$TutorialDisplay.show()
					$TutorialAnimator.play("tutorial_1_animation")
					$"../PauseMenu".pause()
					tutorial_step += 1
				else:
					tutorial_step += 2 # skip both this one and the response to building
			1:
				if SunlightManager.spent_any:
					in_tutorial = true
					$TutorialDisplay/WillyWorried.show()
					$TutorialDisplay.show()
					$TutorialAnimator.play("tutorial_2_animation")
					$"../PauseMenu".pause()
					tutorial_step += 1
			_:
				$TutorialTimer.stop()

func _input(event):
	if event.is_action_pressed("esc") and in_tutorial:
		if $TutorialAnimator.is_playing():
			$TutorialAnimator.advance(10)
		else:
			in_tutorial = false
			await get_tree().create_timer(0.1).timeout
			$TutorialDisplay.hide()
			$"../PauseMenu".unpause()
			for text in $TutorialDisplay/TutorialTexts.get_children():
				text.visible_ratio = 0
