extends StaticBody2D
class_name BaseTree

@export var sunlight_per_second = 1

var sun_timer: Timer;

func _ready():
	print("BaseTree ready")
	sun_timer = Timer.new()
	sun_timer.set_wait_time(1)
	sun_timer.set_one_shot(false)
	sun_timer.timeout.connect(_on_sun_timer_timeout)
	add_child(sun_timer)
	sun_timer.start()
	_load_bullet()

func _on_sun_timer_timeout():
	print("sunlight timer timeout")
	if $HealthComponent.is_full_health():
		SunlightManager.bank_sunlight(sunlight_per_second)
	else:
		$HealthComponent.heal(sunlight_per_second)
		
func _load_bullet():
	print("add bullet to tower, see thorn")
