extends CharacterBody2D
class_name Enemy

@onready var main_scene: Main  = $"../../Main"
@onready var tile_map = $"../TileMap"
@onready var sprite = $Sprite2D
@onready var healthComponent = $HealthComponent
@onready var mother_tree = $"../MotherTree"

var astar_grid: AStarGrid2D
var is_moving = false

@export var speed = 1
@export var mother_tree_damage = 1

func _physics_process(_delta):
	move()

func move():
	var path := main_scene.get_enemy_path(global_position)
	path.pop_front()

	if path.is_empty():
		queue_free()
		return

	var new_pos = tile_map.map_to_local(path.front())
	global_position = global_position.move_toward(new_pos, speed)



func damage_mother_tree() -> void:
	if mother_tree:
		mother_tree.health_component.take_damage(mother_tree_damage)
		queue_free()
		
func heal_full():
	if $HealthComponent:
		$HealthComponent.heal_full()
