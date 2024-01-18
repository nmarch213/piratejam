extends Area2D
class_name Bullet

var speed = 1000 
var target: Enemy = null
var bullet_damage: int = 1
var cleanup_bullet = false

func _physics_process(delta):
	if !cleanup_bullet:
		_destroy_bullet_after_seconds(3)
		cleanup_bullet = true
	if not is_instance_valid(target):  
		return
	if target:
		var direction = (target.global_position - global_position).normalized()
		global_position += direction * speed * delta
	else:
			global_position += Vector2(0, -speed * delta)
	if global_position.y < -100:
			queue_free()


func _destroy_bullet_after_seconds(seconds):
	await get_tree().create_timer(seconds).timeout;
	queue_free()


func _on_bullet_body_entered(body):
		if body is Enemy:
				body.healthComponent.take_damage(bullet_damage)
				queue_free()
