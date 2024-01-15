extends TileMap

enum LAYER { 
	BASE = 0,
	SPREADING_GRASS = 1,
	TOWERS = 2,
	GRID = 3,
}

func _process(_delta):
	var tile := local_to_map(get_local_mouse_position())
	clear_layer(LAYER.GRID)
	if tile:
		set_cell(LAYER.GRID, tile, 4, Vector2i(1,0), 0)
