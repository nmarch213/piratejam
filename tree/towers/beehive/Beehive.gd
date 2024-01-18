extends BaseTree 
class_name Beehive

@onready var attack_component: AttackComponent = $AttackComponent
@onready var bullet = preload("res://tree/towers/beehive/BeehiveBullet.tscn")

func _load_bullet():
	attack_component.bullet = bullet;
	attack_component.attack_speed = 5
