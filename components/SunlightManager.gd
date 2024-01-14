extends Control

var sunlight_banked = 0

func bank_sunlight(amount):
	sunlight_banked += amount
	print(sunlight_banked)
	
func is_affordable(amount):
	amount <= sunlight_banked
	
func spend_sunlight(amount):
	sunlight_banked -= amount
