extends Node2D
class_name HealthComponent

@onready var timer = $HealthBar/Timer
@onready var health_bar = $HealthBar
@onready var damage_bar = $HealthBar/DamageBar

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

func damage(attack: Attack):
	health -= attack.damage
	health_bar.value = health
	damage_bar.value = attack.damage
	if health <= 0:
		get_parent().queue_free()

func _on_timer_timeout():
	damage_bar.value = health

