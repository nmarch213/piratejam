extends Node2D

@onready var wave_timer: Timer = $WaveTimer;
var current_wave = 0
var BASE_WAVE_STRENGTH = 1
var UNIT_COSTS = {
	"flame": 1,
	"blaze": 3,
	"cloud": 5,
	"lava_elemental": 10
}
var all_spawn_points = []
var active_spawn_points = []

func _ready():
	SunlightManager.first_purchase.connect(_on_first_purchase_by_player)
	$WaveTimer.timeout.connect(_on_wave_timer_timeout)
	update_spawn_points()
	
func _on_first_purchase_by_player():
	# do not start spawning until player starts playing
	wave_timer.start()
	
func _on_wave_timer_timeout():
	update_spawn_points()
	var wave = build_wave()
	spawn_wave(wave)
	current_wave += 1
	if current_wave % 25 == 0:
		activate_new_spawn_point()
	
func activate_new_spawn_point():
	var new_spawn_point = all_spawn_points.filter(func(spawn_point): return not spawn_point.active).pick_random()
	if new_spawn_point:
		new_spawn_point.active = true

func build_wave():
	var spend = wave_strength()
	var wave = {
		"flame": 0,
		"blaze": 0,
		"cloud": 0,
		"lava_elemental": 0
	}
	
	# lava eles
	if current_wave >= 15:
		if current_wave % 5 == 0:
			wave["lava_elemental"] += 1
			spend -= UNIT_COSTS["lava_elemental"]
		var lava_eles = generate_enemies(wave, spend/2, "lava_elemental")
		wave["lava_elemental"] += lava_eles
		spend -= (UNIT_COSTS["lava_elemental"] * lava_eles)

	# clouds
	if current_wave >= 10:
		var clouds = generate_enemies(wave, spend/2, "cloud")
		wave["cloud"] += clouds
		spend -= (UNIT_COSTS["cloud"] * clouds)
		
	# blazes
	if current_wave >= 5:
		var blazes = generate_enemies(wave, spend, "blaze")
		wave["blaze"] += blazes
		spend -= (UNIT_COSTS["blaze"] * blazes)
		
	# flames -- fill the wave
	var flames = spend / UNIT_COSTS["flame"]
	wave["flame"] += flames
	spend -= (UNIT_COSTS["flame"] * flames)
	
	return wave

func generate_enemies(wave, max_spend, unit_name):
	return randi_range(0, max_spend) / UNIT_COSTS[unit_name]

func wave_strength():
	return (BASE_WAVE_STRENGTH * active_spawn_points.size()) + current_wave

func update_spawn_points():
	all_spawn_points = get_parent().get_children().filter(func(child): return child is Spawner)
	active_spawn_points = all_spawn_points.filter(func(spawn_point): return spawn_point.active)
	if active_spawn_points.is_empty():
		# if the player destroyed all active ones, choose one at random
		active_spawn_points = all_spawn_points.pick_random()

func spawn_wave(wave: Dictionary):
	var spawn_points = active_spawn_points.duplicate()
	var final_spawn_point = spawn_points.pop_front()
	for spawn_point in spawn_points:
		var spawn_point_wave = {
			"flame": randi_range(0, wave["flame"]),
			"blaze": randi_range(0, wave["blaze"]),
			"cloud": randi_range(0, wave["cloud"]),
			"lava_elemental": randi_range(0, wave["lava_elemental"]),
		}
		wave["flame"] -= spawn_point_wave["flame"]
		wave["blaze"] -= spawn_point_wave["blaze"]
		wave["cloud"] -= spawn_point_wave["cloud"]
		wave["lava_elemental"] -= spawn_point_wave["lava_elemental"]
		spawn_point.spawn_enemies(spawn_point_wave)
	final_spawn_point.spawn_enemies(wave)
