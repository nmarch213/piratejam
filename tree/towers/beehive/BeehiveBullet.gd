extends Bullet
class_name BeehiveBullet

var timer: Timer
var aoe_img = preload("res://tree/towers/beehive/beehiveBeehive.png")
@export var ticks_per_second: int = 1
@export var aoe_radius: float = 100.0
@export var aoe_ttl: float = 2.0
@export var aoe_dmg: int = 5

var first_hit: Enemy;
var spawn_count: int = 0
var enemies_in_aoe = []
var aoe_area: Area2D
var bodies_hit: Array[Enemy] = []
var has_aoe_spawned = false

func _ready():
	speed = 500
	bullet_damage = 5
	self.body_entered.connect(_on_bullet_body_entered)
	_setup_timer()

func _spawn_aoe_area(body: Enemy):
	aoe_area = Area2D.new()
	var collision = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	var aoe_timer := Timer.new()
	aoe_timer.timeout.connect(_on_aoe_timout)
	aoe_timer.set_wait_time(aoe_ttl)
	aoe_timer.set_autostart(true)
	aoe_timer.set_paused(false)
	timer.set_one_shot(true)
	shape.radius = aoe_radius
	collision.shape = shape
	aoe_area.body_entered.connect(_on_aoe_area_entered)
	aoe_area.body_exited.connect(_on_aoe_area_exited)
	aoe_area.monitoring = true

	aoe_area.add_child(aoe_timer)
	aoe_area.add_child(collision)
	aoe_area.add_child(create_visual_representation())

	get_tree().root.call_deferred("add_child", aoe_area)
	aoe_area.global_position = body.global_position


func _on_aoe_timout():
	print("aoe timeout", aoe_area.name)
	aoe_area.queue_free()

func _on_aoe_area_entered(body):
	if body is Enemy:
		if body not in enemies_in_aoe:
			enemies_in_aoe.append(body)

func _on_aoe_area_exited(body):
	if body is Enemy:
		if body in enemies_in_aoe:
			enemies_in_aoe.erase(body)

func _setup_timer():
	timer = Timer.new()
	timer.set_wait_time(ticks_per_second)
	timer.timeout.connect(_on_timer_timeout)
	timer.autostart = true
	timer.one_shot = true 
	add_child(timer)

func _on_timer_timeout():
	for enemy in enemies_in_aoe:
		enemy.healthComponent.take_damage(aoe_dmg)
	timer.start()

func create_visual_representation() -> Sprite2D:
	var sprite = Sprite2D.new()
	sprite.texture = aoe_img
	return sprite

func _on_bullet_body_entered(body: Enemy):
	if body is Enemy:
		body.healthComponent.take_damage(bullet_damage)
		bodies_hit.append(body)
	
	_hit_first_enemy(bodies_hit)
	

func _hit_first_enemy(enemies: Array[Enemy]):
	if has_aoe_spawned == false:
		has_aoe_spawned = true
		call_deferred("_spawn_aoe_area", enemies[0])
