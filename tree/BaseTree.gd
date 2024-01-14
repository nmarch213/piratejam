extends StaticBody2D
class_name BaseTree

@export var sunlight_per_second = 1

func _on_sun_timer_timeout():
	if $HealthComponent.is_max_health():
		SunlightManager.bank_sunlight(sunlight_per_second)
	else:
		$HealthComponent.heal(sunlight_per_second)
		
	
