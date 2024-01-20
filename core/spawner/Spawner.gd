extends Marker2D

var blaze: PackedScene = preload("res://enemies/blaze/Blaze.tscn")
var flame: PackedScene = preload("res://enemies/flame/flame.tscn")
var smoke_cloud: PackedScene = preload("res://enemies/smoke_cloud/smoke_cloud.tscn")
var lava_elemental: PackedScene = preload("res://enemies/lava_elemental/lava_elemental.tscn")

@onready var wave_timer: Timer = $WaveTimer;

var current_wave = 0
var wave_strength = 0

func _ready():
	wave_timer.start()

func spawn_wave():
	var blazes = randi_range(0, wave_strength) / 2
	var clouds = randi_range(0, wave_strength) / 2
	var flames = wave_strength
	
	for a_blaze in blazes:
		spawn_enemy(blaze)
		await $SpawnTimer.timeout
		
	for a_cloud in clouds:
		spawn_enemy(smoke_cloud)
		await $SpawnTimer.timeout

	for a_flame in flames:
		spawn_enemy(flame)
		await $SpawnTimer.timeout
	
		
func spawn_enemy(enemy_type: PackedScene):
	var enemy = enemy_type.instantiate()
	enemy.position = global_position
	enemy.position.x = randfn(enemy.position.x, 10)
	enemy.position.y = randfn(enemy.position.y, 10)
	get_parent().add_child(enemy)

func _on_wave_timer_timeout():
	if current_wave % 3 == 0:
		spawn_enemy(lava_elemental)
	if current_wave % 8 == 0:
		wave_strength += 3
		
	spawn_wave()
	current_wave += 1
