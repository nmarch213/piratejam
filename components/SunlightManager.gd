extends Control

var sunlight_banked = 0

func bank_sunlight(amount):
	sunlight_banked += amount
	
func is_affordable(amount):
	return amount <= sunlight_banked
	
func spend_sunlight(amount):
	sunlight_banked -= amount
