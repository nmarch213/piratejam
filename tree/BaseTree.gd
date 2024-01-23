extends StaticBody2D
class_name BaseTree

@export var sunlight_per_second: int = 1
@export var healing_wait_time: float = 3
@export var healing_per_tick: int = 5
@onready var healthComponent = $HealthComponent
@onready var tile_map = $"../TileMap"
var attack_component

var bank_sunlight_timer: Timer;
var heal_self_timer: Timer;
var tower_hovered: bool = false

func _ready():
	# create timer for banking sunlight
	_setup_sunlight_timer()
	# create timer for healing mother tree
	_setup_heal_timer()
	_load_bullet()
	attack_component = $AttackComponent
	if attack_component:
		_setup_hover()

func _setup_hover():
	input_pickable = true
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_exited():
	tower_hovered = false
	queue_redraw()

func _on_mouse_entered():
	tower_hovered = true
	queue_redraw()

func _draw():
	if tower_hovered:
		draw_circle(Vector2.ZERO, attack_component.attack_range, Color(1, 0, 0, 0.5))

func _setup_sunlight_timer():
	bank_sunlight_timer = Timer.new()
	bank_sunlight_timer.set_wait_time(1)
	bank_sunlight_timer.set_one_shot(false)
	bank_sunlight_timer.timeout.connect(_on_bank_sunlight_timer_timeout)
	add_child(bank_sunlight_timer)
	bank_sunlight_timer.start()

func _setup_heal_timer():
	heal_self_timer = Timer.new()
	heal_self_timer.set_wait_time(healing_wait_time)
	heal_self_timer.set_one_shot(false)
	heal_self_timer.timeout.connect(_on_heal_self_timer_timeout)
	add_child(heal_self_timer)
	heal_self_timer.start()

func _on_bank_sunlight_timer_timeout():
	if $HealthComponent.is_full_health():
		SunlightManager.bank_sunlight(sunlight_per_second)
		
func _on_heal_self_timer_timeout():
	if !$HealthComponent.is_full_health():
		$HealthComponent.heal(healing_per_tick)			
		
func _load_bullet():
	print("add bullet to tower, see thorn")
