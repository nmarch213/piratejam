extends BaseTree
class_name MotherTree

@onready var health_component = $HealthComponent
@onready var animation_player = $Sprite2D/AnimationPlayer
func _ready():
	super._ready()
	animation_player.play("default")

func _on_area_2d_body_entered(body:Node2D):
	if body.is_in_group("Enemy"):
		var enemy: Enemy = body
		enemy.damage_mother_tree()
