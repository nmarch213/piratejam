extends BaseTree
class_name MotherTree

@onready var health_component = $HealthComponent

func _ready():
	sunlight_per_second = 5

func _on_area_2d_body_entered(body:Node2D):
	if body.is_in_group("Enemy"):
		var enemy: Enemy = body
		enemy.damage_mother_tree()
