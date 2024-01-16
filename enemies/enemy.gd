extends CharacterBody2D
class_name Enemy

@onready var main_scene: Main  = $"../../Main"
@onready var tile_map = $"../TileMap"
@onready var sprite = $Sprite2D
@onready var healthComponent = $HealthComponent
@onready var mother_tree = $"../MotherTree"

var astar_grid: AStarGrid2D
var is_moving = false

@export var damage = 10

func _process(_delta):
	if is_moving:
		return

	move()

func move():
	var path := main_scene.get_enemy_path(global_position)
		
	path.pop_front()

	if path.is_empty():
		queue_free()
		return

	var original_pos = global_position;
	global_position = tile_map.map_to_local(path.front())
	sprite.global_position =  original_pos

	is_moving = true

func _physics_process(_delta):
	if is_moving:
		sprite.global_position = sprite.global_position.move_toward(global_position, 1)

	if sprite.global_position != global_position:
		return

	is_moving = false

func damage_mother_tree() -> void:
	if mother_tree:
		mother_tree.health_component.take_damage(damage)
		queue_free()


