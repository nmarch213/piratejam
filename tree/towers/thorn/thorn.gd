extends StaticBody2D

var bullet = preload("res://tree/towers/thorn/thorn_bullet.tscn")
@onready var attack_component: AttackComponent = $AttackComponent

func _ready():
	attack_component.bullet = bullet
