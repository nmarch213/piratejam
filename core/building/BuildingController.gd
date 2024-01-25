extends Node2D

var costs = {
	0: 100,
	1: 225,
	2: 800
}

@onready var tile_map = $"../TileMap"
@onready var main = $".."
@onready var tile_click_controller = $"../TileClickController"
@onready var buy_menu = $"../TileClickController/BuyMenu"

func _ready():
	buy_menu.id_pressed.connect(_on_buy_menu_id_pressed)


func _on_buy_menu_id_pressed(id):
	# if the user clicked sapling in the menu
	if SunlightManager.is_affordable(costs[id]):
		SunlightManager.spend_sunlight(costs[id])
		match id:
			0: place_sapling_tower(tile_click_controller.latest_cell_clicked)
			1: place_thorn_tower(tile_click_controller.latest_cell_clicked)
			2: place_beehive_tower(tile_click_controller.latest_cell_clicked)

	
	
func place_sapling_tower(cell_clicked_position: Vector2i) -> void:
	tile_map.set_cell(tile_map.LAYER.TOWERS, cell_clicked_position, 3, Vector2(0,0), 1)
	main.astar_grid.set_point_solid(cell_clicked_position, true)
	spread_grass(cell_clicked_position)

func place_thorn_tower(cell_clicked_position: Vector2i) -> void:
	tile_map.set_cell(tile_map.LAYER.TOWERS, cell_clicked_position, 3, Vector2(0,0), 2)
	main.astar_grid.set_point_solid(cell_clicked_position, true)
	spread_grass(cell_clicked_position)


func place_beehive_tower(cell_clicked_position: Vector2i) -> void:
	tile_map.set_cell(tile_map.LAYER.TOWERS, cell_clicked_position, 3, Vector2(0,0), 3)
	main.astar_grid.set_point_solid(cell_clicked_position, true)
	spread_grass(cell_clicked_position)

func spread_grass(cell_clicked_position: Vector2i) -> void:
	for x in range(-1, 2):
		for y in range(-1, 2):
			var grass_pos = Vector2i(x, y) + cell_clicked_position
			if not tile_map.get_cell_tile_data(tile_map.LAYER.BARRIER, grass_pos):
				await $GrassTimer.timeout
				tile_map.set_cell(tile_map.LAYER.BASE, grass_pos, 4, Vector2(0,0), 0)	


