extends Node2D
class_name AttackComponent

var bullet: PackedScene;
@export var attack_damage = 1
@export var attack_speed = 1
@export var attack_range = 100
@export var crit_chance = 0
@export var aoe = 0

var targets_in_range = []
var bullet_container: Node2D
var timer: Timer
# @export var enemy_prio
# @export var attack_type - Piercing, Slashing, Blunt, Fire, Ice, Lightning, Poison, Magic, Holy, Dark
# @export var attack_element - Fire, Ice, Lightning, Poison, Magic, Holy, Dark

func _ready():
	create_attack_range()
	_setup_attack_timer()
	bullet_container = Node2D.new()
	bullet_container.name = "Bullets"
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
	if valid_target_for_me(body) and (body not in targets_in_range):
			targets_in_range.append(body)
		

func _on_range_body_exited(body):
	if valid_target_for_me(body):
		targets_in_range.erase(body)

func valid_target_for_me(body):
	if (get_parent() is BaseTree and body is Enemy) \
	or (get_parent() is Enemy and body is BaseTree):
		return true

func _setup_attack_timer():
	timer = Timer.new()
	timer.wait_time = attack_speed
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	fire_at_enemy() if get_parent() is BaseTree else fire_at_trees()
	
func fire_at_enemy():
	if targets_in_range.size() > 0:
		shoot_bullet_at_enemy(targets_in_range[0])
		
func fire_at_trees():
	for tree in targets_in_range:
		tree.healthComponent.take_damage(attack_damage)

func shoot_bullet_at_enemy(body: Enemy):
	var bullet_shot = bullet.instantiate()
	bullet_shot.target = body
	bullet_container.add_child(bullet_shot)

