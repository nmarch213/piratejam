extends Node2D
class_name HealthComponent

@onready var timer = $HealthBar/Timer
@onready var health_bar = $HealthBar
@onready var damage_bar = $HealthBar/DamageBar

signal death

@export var MAX_HEALTH = 10
var health: float : set = _set_health

func _set_health(new_health: float):
	var prev_health = health
	health = min(MAX_HEALTH, new_health)
	health_bar.value = health

	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health

func _ready():
	health = MAX_HEALTH
	health_bar.value = health
	health_bar.max_value = MAX_HEALTH
	damage_bar.value = health
	damage_bar.max_value = MAX_HEALTH
	if is_full_health():
		health_bar.hide()

func take_damage(dmg: float):
	health -= dmg
	health_bar.value = health
	damage_bar.value = dmg
	if health <= 0:
		death.emit()
		get_parent().queue_free()
	health_bar.show()
		
func heal(amount):
	health = min(health + amount, MAX_HEALTH)
	health_bar.value = health
	if is_full_health():
		health_bar.hide()
	
func is_full_health():
	return health == MAX_HEALTH

func _on_timer_timeout():
	damage_bar.value = health

func heal_full():
	heal(MAX_HEALTH)
