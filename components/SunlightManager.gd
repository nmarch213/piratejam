extends Control

var starting_sunlight_banked = 1000
var sunlight_banked = starting_sunlight_banked
var spent_any = false

signal first_purchase

func bank_sunlight(amount):
	if spent_any:
		sunlight_banked += amount
	
func is_affordable(amount):
	return amount <= sunlight_banked
	
func spend_sunlight(amount):
	sunlight_banked -= amount
	if not spent_any:
		spent_any = true
		first_purchase.emit()
