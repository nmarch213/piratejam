extends Area2D 

func _ready():
	$DespawnTimer.timeout.connect(_on_despawn_timer_timeout)
	self.body_entered.connect(_on_body_entered)
	
func _on_despawn_timer_timeout():
	queue_free()

func _on_body_entered(body:Node2D):
	if body is Enemy and !(body is LavaElemental):
		var enemy: Enemy = body
		enemy.heal_full()
