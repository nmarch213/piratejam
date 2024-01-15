extends CharacterBody2D
class_name Enemy

@onready var tile_map = $"../TileMap"
@onready var sprite = $Sprite2D
@export var tree: MotherTree

var astar_grid: AStarGrid2D
var is_moving = false

func _ready():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	astar_grid.cell_size = Vector2(32,32)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()

	var region_size = astar_grid.region.size
	var region_pos = astar_grid.region.position

	for x in region_size.x:
		for y in region_size.y:
			var tile_pos = Vector2i(x + region_pos.x, y + region_pos.y)
			var tile_data = tile_map.get_cell_tile_data(0, tile_pos)

			if tile_data == null or not tile_data.get_custom_data("base"):
				astar_grid.set_point_solid(tile_pos)


func _process(_delta):
	if is_moving:
		return

	move()

func move():
	var path = astar_grid.get_id_path(
			tile_map.local_to_map(global_position),
			tile_map.local_to_map(tree.global_position),
		)
		
	path.pop_front()

	if path.is_empty():
		print("No path found")
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





