extends Node2D
class_name Main


@onready var tile_map = $TileMap;
@onready var mother_tree = $MotherTree

var sapling: PackedScene = preload("res://tree/towers/sapling/sapling.tscn")
var astar_grid: AStarGrid2D
var mother_tree_global_position: Vector2 = Vector2(0, 0)

func _ready():
	_setup_astargrid()
	mother_tree_global_position = mother_tree.global_position


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

			if solid_on_grid(tile_pos):
				astar_grid.set_point_solid(tile_pos)

func solid_on_grid(tile_pos):
	var base_layer = tile_map.get_cell_tile_data(tile_map.LAYER.BASE, tile_pos)
	var barrier_layer = tile_map.get_cell_tile_data(tile_map.LAYER.BARRIER, tile_pos)
	if base_layer == null \
	or not base_layer.get_custom_data("base") \
	or barrier_layer != null:
		return true


func add_tower_to_grid(tower_pos: Vector2) -> void:
	# this makes it so that the tower is not a walkable point
	astar_grid.set_point_solid(tower_pos, true)

func get_enemy_path(enemy_pos: Vector2) -> Array[Vector2i]:
	var path := astar_grid.get_id_path(
			tile_map.local_to_map(enemy_pos),
			tile_map.local_to_map(mother_tree_global_position),
		)

	return path



