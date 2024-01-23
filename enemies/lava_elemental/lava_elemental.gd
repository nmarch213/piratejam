extends Enemy
class_name LavaElemental

var ember: PackedScene = preload("res://enemies/ember/ember.tscn")
var lava: PackedScene = preload("res://enemies/lava_elemental/lava/lava.tscn")

func _ready():
	speed = 0.2
	$HealthComponent.death.connect(_on_health_component_death)
	$LavaTimer.timeout.connect(_on_lava_timer_timeout)

func _on_health_component_death():
	var remains = ember.instantiate()
	remains.position = global_position
	get_parent().call_deferred("add_child", remains)

func _on_lava_timer_timeout():
	var lava = lava.instantiate()
	lava.position.x = global_position.x - 24
	lava.position.y = global_position.y + 24
	get_parent().add_child(lava)

	
