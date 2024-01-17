extends Enemy 

var flame: PackedScene = preload("res://enemies/flame/flame.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	speed = 0
	
func _on_respawn_timer_timeout():
	if rng.randf() > 0.66:
		var respawned_foe = flame.instantiate()
		respawned_foe.position = global_position
		get_parent().add_child(respawned_foe)
		queue_free()
