extends Control

var starting_sunlight_banked = 1000
var sunlight_banked = starting_sunlight_banked

func bank_sunlight(amount):
	sunlight_banked += amount
	
func is_affordable(amount):
	return amount <= sunlight_banked
	
func spend_sunlight(amount):
	sunlight_banked -= amount
