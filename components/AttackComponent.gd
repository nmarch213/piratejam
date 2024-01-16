extends Node2D
class_name AttackComponent

var bullet: PackedScene;
@export var attack_damage = 1
@export var attack_speed = .1
@export var attack_range = 100
@export var crit_chance = 0
@export var aoe = 0

var enemies_in_range = []
var bullet_container: Node2D
var timer: Timer
# @export var enemy_prio
# @export var attack_type - Piercing, Slashing, Blunt, Fire, Ice, Lightning, Poison, Magic, Holy, Dark
# @export var attack_element - Fire, Ice, Lightning, Poison, Magic, Holy, Dark

func _ready():
	create_attack_range()
	_setup_attack_timer()
	bullet_container = Node2D.new()
	bullet_container.name = "EnemyContainer"
	add_child(bullet_container)

func create_attack_range():
	var area := Area2D.new()
	area.name = "Range"
	var collision = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = attack_range
	collision.shape = shape
	area.body_entered.connect(_on_range_body_entered)
	area.body_exited.connect(_on_range_body_exited)
	area.monitoring = true
	area.add_child(collision)
	add_child(area)

func _on_range_body_entered(body):
	if body is Enemy:
		if body not in enemies_in_range:
			enemies_in_range.append(body)

func _on_range_body_exited(body):
	if body is Enemy:
		if body in enemies_in_range:
			enemies_in_range.erase(body)

func _attack(enemy: Enemy):
	var damage = attack_damage
	if randf() < crit_chance:
		damage *= 2
	enemy.healthComponent.take_damage(damage)

func _setup_attack_timer():
	timer = Timer.new()
	timer.wait_time = attack_speed
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	if enemies_in_range.size() > 0:
		# _attack(enemies_in_range[0])
		shoot_bullet_at_enemy(enemies_in_range[0])

func shoot_bullet_at_enemy(body: Enemy):
	var bullet_shot = bullet.instantiate()
	bullet_shot.target = body
	bullet_container.add_child(bullet_shot)
	


