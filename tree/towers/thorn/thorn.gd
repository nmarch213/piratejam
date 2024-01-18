extends BaseTree
class_name Thorn


@onready var attack_component: AttackComponent = $AttackComponent
@onready var bullet = load("res://tree/towers/thorn/thorn_bullet.tscn")

func _load_bullet():
	attack_component.bullet = bullet;
