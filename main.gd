extends Node2D
class_name Main


@onready var tile_map = $TileMap;
@export var tree: MotherTree

var sapling: PackedScene = preload("res://towers/sapling/Sapling.tscn")

var astar_grid: AStarGrid2D

func _ready():
	_setup_astargrid()
	# these are the placeholder towers, they are not walkable
	# when we add the ability to place towers we will need to
	# add them to the astar grid like shown below
	add_tower_to_grid(Vector2i(30, 25))
	add_tower_to_grid(Vector2i(30, 26))
	add_tower_to_grid(Vector2i(31, 27))
	add_tower_to_grid(Vector2i(32, 28))
	add_tower_to_grid(Vector2i(33, 29))
	add_tower_to_grid(Vector2i(34, 29))

func _input(_event):
	if Input.is_action_just_pressed("Place"):
		place_sapling_tower()


func _setup_astargrid():
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

func add_tower_to_grid(tower_pos: Vector2) -> void:
	# this makes it so that the tower is not a walkable point
	astar_grid.set_point_solid(tower_pos, true)

func get_enemy_path(enemy_pos: Vector2) -> Array[Vector2i]:
	var path := astar_grid.get_id_path(
			tile_map.local_to_map(enemy_pos),
			tile_map.local_to_map(tree.global_position),
		)

	return path

func place_sapling_tower() -> void:
	var mouse_pos = get_global_mouse_position()
	var tile_pos = tile_map.local_to_map(mouse_pos)
	# this will add the sapling to the tilemap
	# 3 is the layer
	# source ID in godot is 3,
	# 1 is the Alternate ID for the sapling
	tile_map.set_cell(3, tile_pos, 3, Vector2(0,0), 1)
	astar_grid.set_point_solid(tile_pos, true)

