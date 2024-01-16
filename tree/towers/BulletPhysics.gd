extends Node2D 
class_name Bullet

var speed = 1000 
var target: Enemy = null
var bullet_damage = 1

func _ready():
	await get_tree().create_timer(3).timeout;
	queue_free()

func _physics_process(delta):
	if not is_instance_valid(target):  
		return
	if target:
		var direction = (target.global_position - global_position).normalized()
		global_position += direction * speed * delta
	else:
			global_position += Vector2(0, -speed * delta)
	if global_position.y < -100:
			queue_free()

func _on_body_entered(body):
		if body is Enemy:
				body.healthComponent.take_damage(bullet_damage)
				queue_free()
