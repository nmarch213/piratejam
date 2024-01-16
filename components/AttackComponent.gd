extends Node2D
class_name Attack

@onready var bullet = $Bullet

@export var attack_damage = 1
@export var attack_speed = 1
@export var attack_range = 100
@export var crit_chance = 0
@export var aoe = 0

# @export var enemy_prio
# @export var attack_type - Piercing, Slashing, Blunt, Fire, Ice, Lightning, Poison, Magic, Holy, Dark
# @export var attack_element - Fire, Ice, Lightning, Poison, Magic, Holy, Dark

func _ready():
	create_attack_range()

func create_attack_range():
	print("Creating attack range")
	var area := Area2D.new()
	area.name = "Range"
	var collision = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = attack_range
	collision.shape = shape
	area.body_entered.connect(_on_range_body_entered)
	area.monitoring = true
	area.add_child(collision)
	add_child(area)

func _on_range_body_entered(body):
	print(body.name)
	if body is Enemy:
		_attack(body)

func _attack(enemy: Enemy):
	var damage = attack_damage
	if randf() < crit_chance:
		damage *= 2
	enemy.healthComponent.take_damage(damage)



