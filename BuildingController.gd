extends Node2D

var costs = {
	0: 100,
	1: 400
}

@onready var tile_map = $"../TileMap"
@onready var main = $".."
@onready var tile_click_controller = $"../TileClickController"



func _on_buy_menu_id_pressed(id):
	# if the user clicked sapling in the menu
	if SunlightManager.is_affordable(costs[id]):
		SunlightManager.spend_sunlight(costs[id])
		match id:
			0: place_sapling_tower(tile_click_controller.latest_cell_clicked)
			1: place_thorn_tower(tile_click_controller.latest_cell_clicked)

	
	
func place_sapling_tower(cell_clicked_position: Vector2i) -> void:
	tile_map.set_cell(tile_map.LAYER.TOWERS, cell_clicked_position, 3, Vector2(0,0), 1)
	main.astar_grid.set_point_solid(cell_clicked_position, true)
	spread_grass(cell_clicked_position)

func place_thorn_tower(cell_clicked_position: Vector2i) -> void:
	tile_map.set_cell(tile_map.LAYER.TOWERS, cell_clicked_position, 3, Vector2(0,0), 2)
	main.astar_grid.set_point_solid(cell_clicked_position, true)
	spread_grass(cell_clicked_position)

func spread_grass(cell_clicked_position: Vector2i) -> void:
	for x in range(-1, 2):
		for y in range(-1, 2):
			await get_tree().create_timer(.1).timeout
			var grass_pos = Vector2i(x, y) + cell_clicked_position
			tile_map.set_cell(tile_map.LAYER.BASE, grass_pos, 4, Vector2(0,0), 0)	


