extends Control

var starting_sunlight_banked: int = 1000
var sunlight_banked := starting_sunlight_banked

func bank_sunlight(amount: int) -> void:
	sunlight_banked += amount
var starting_sunlight_banked = 1000
var sunlight_banked = starting_sunlight_banked
var spent_any = false

signal first_purchase

func bank_sunlight(amount):
	if spent_any:
		sunlight_banked += amount
	
func is_affordable(amount: int) -> bool:
	return amount <= sunlight_banked
	
func spend_sunlight(amount: int) -> void:
	sunlight_banked -= amount
	if not spent_any:
		spent_any = true
		first_purchase.emit()
