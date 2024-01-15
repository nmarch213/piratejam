extends Node2D

@onready var tile_map = $"../TileMap"
@onready var main = $".."



func _on_tile_map_tile_map_clicked(cell_clicked_position: Vector2i):
	print("clicked", cell_clicked_position)
	place_sapling_tower(cell_clicked_position)
	
	
func place_sapling_tower(cell_clicked_position: Vector2i) -> void:
	# this will add the sapling to the tilemap
	# 3 is the layer
	# source ID in godot is 3,
	# 1 is the Alternate ID for the sapling
	tile_map.set_cell(tile_map.LAYER.TOWERS, cell_clicked_position, 3, Vector2(0,0), 1)
	main.astar_grid.set_point_solid(cell_clicked_position, true)
	spread_grass(cell_clicked_position)

func spread_grass(cell_clicked_position: Vector2i) -> void:
	for x in range(-1, 2):
		for y in range(-1, 2):
			await get_tree().create_timer(.1).timeout
			var grass_pos = Vector2i(x, y) + cell_clicked_position
			tile_map.set_cell(tile_map.LAYER.BASE, grass_pos, 4, Vector2(0,0), 0)	
