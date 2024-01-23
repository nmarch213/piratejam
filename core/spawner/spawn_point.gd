extends Enemy
class_name Spawner

var FLAME: PackedScene = preload("res://enemies/flame/flame.tscn")
var BLAZE: PackedScene = preload("res://enemies/blaze/blaze.tscn")
var CLOUD: PackedScene = preload("res://enemies/smoke_cloud/smoke_cloud.tscn")
var LAVA_ELEMENTAL: PackedScene = preload("res://enemies/lava_elemental/lava_elemental.tscn")
var ENEMY_TYPES_BY_NAME = {
	"flame": FLAME,
	"blaze": BLAZE,
	"cloud": CLOUD,
	"lava_elemental": LAVA_ELEMENTAL
}
@export var active = false

func _ready():
	speed = 0 # this is move speed
	
func spawn_enemies(enemies: Dictionary):
	var enemy_types = enemies.keys()
	enemy_types.shuffle()
	for enemy_type in enemy_types:
		for count in enemies[enemy_type]:
			spawn_enemy(ENEMY_TYPES_BY_NAME[enemy_type])
		
func spawn_enemy(enemy_type: PackedScene):
	await $SpawnTimer.timeout
	var enemy = enemy_type.instantiate()
	enemy.position = global_position
	enemy.position.x = randfn(enemy.position.x, 10)
	enemy.position.y = randfn(enemy.position.y, 10)
	get_parent().add_child(enemy)


