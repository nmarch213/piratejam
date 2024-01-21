extends StaticBody2D
class_name BaseTree

@export var sunlight_per_second = 1
@export var healing_wait_time = 3
@export var healing_per_tick = 5
@onready var healthComponent = $HealthComponent

var bank_sunlight_timer: Timer;
var heal_self_timer: Timer;

func _ready():
	print("BaseTree ready")
	
	# create timer for banking sunlight
	bank_sunlight_timer = Timer.new()
	bank_sunlight_timer.set_wait_time(1)
	bank_sunlight_timer.set_one_shot(false)
	bank_sunlight_timer.timeout.connect(_on_bank_sunlight_timer_timeout)
	add_child(bank_sunlight_timer)
	bank_sunlight_timer.start()
	
	# create timer for healing mother tree
	heal_self_timer = Timer.new()
	heal_self_timer.set_wait_time(healing_wait_time)
	heal_self_timer.set_one_shot(false)
	heal_self_timer.timeout.connect(_on_heal_self_timer_timeout)
	add_child(heal_self_timer)
	heal_self_timer.start()
	
	_load_bullet()


func _on_bank_sunlight_timer_timeout():
	if $HealthComponent.is_full_health():
		SunlightManager.bank_sunlight(sunlight_per_second)
		
func _on_heal_self_timer_timeout():
	if !$HealthComponent.is_full_health():
		$HealthComponent.heal(healing_per_tick)			
		
func _load_bullet():
	print("add bullet to tower, see thorn")
