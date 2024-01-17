extends Marker2D

var blaze: PackedScene = preload("res://enemies/blaze/Blaze.tscn")
var flame: PackedScene = preload("res://enemies/flame/flame.tscn")

@onready var wave_timer: Timer = $WaveTimer;

var current_wave = 0

func _ready():
	wave_timer.start()
	


func spawn_wave_1():
	var wave_strength = 10
	# blaze str = 2
	# flame = 1
	
	var blazes = randi_range(0, wave_strength) / 2
	var flames = wave_strength - (blazes * 2)
	for a_blaze in blazes:
		spawn_enemy(blaze)
		await get_tree().create_timer(.3).timeout

	for a_flame in flames:
		spawn_enemy(flame)
		await get_tree().create_timer(.3).timeout
		
func spawn_enemy(enemy_type: PackedScene):
	var enemy = enemy_type.instantiate()
	enemy.position = global_position
	enemy.position.x = randfn(enemy.position.x, 10)
	enemy.position.y = randfn(enemy.position.y, 10)
	get_parent().add_child(enemy)

func _on_wave_timer_timeout():
	current_wave += 1
	match current_wave:
		0:
			spawn_wave_1()
		1:
			spawn_wave_1()
		2:
			spawn_wave_1()
		3:
			spawn_wave_1()
		4:
			spawn_wave_1()
