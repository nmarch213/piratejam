extends Enemy

var ember: PackedScene = preload("res://enemies/ember/ember.tscn")
var mother_tree_coords

func _ready():
	speed = 0.5
	mother_tree = $"../MotherTree"
	mother_tree_coords = mother_tree.position if mother_tree else Vector2(0,0)
		# above logic temporary, errors if mother tree has been destroyed
	$HealthComponent.death.connect(_on_health_component_death)

func _on_health_component_death():
	var remains = ember.instantiate()
	remains.position = global_position
	get_parent().call_deferred("add_child", remains)

func move():
	global_position = global_position.move_toward(mother_tree_coords, speed)
