extends Marker2D

var blaze: PackedScene = preload("res://enemies/blaze/Blaze.tscn")
@onready var wave_timer: Timer = $WaveTimer;

var current_wave = 0

func _ready():
	wave_timer.start()
	


func spawn_wave_1():
	var total_enemies = 5

	for e in total_enemies:
		var enemy = blaze.instantiate()
		enemy.position = global_position
		await get_tree().create_timer(.3).timeout
		get_parent().add_child(enemy)

func _on_wave_timer_timeout():
	print("wave timer")
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
