extends Enemy

var ember: PackedScene = preload("res://enemies/ember/ember.tscn")

func _ready():
	speed = 0.5
	$HealthComponent.death.connect(_on_health_component_death)

func _on_health_component_death():
	var remains = ember.instantiate()
	remains.position = global_position
	get_parent().call_deferred("add_child", remains)
