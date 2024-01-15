extends Control

var sunlight_banked = 1000

func bank_sunlight(amount):
	sunlight_banked += amount
	
func is_affordable(amount):
	return amount <= sunlight_banked
	
func spend_sunlight(amount):
	sunlight_banked -= amount
