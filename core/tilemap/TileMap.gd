extends TileMap

enum LAYER { 
	BASE = 0,
	SPREADING_GRASS = 1,
	TOWERS = 2,
	GRID = 3,
}

signal tile_map_clicked(cell_clicked_position: Vector2i, event_position: Vector2)

func _process(_delta):
	var cell : Vector2i = local_to_map(get_local_mouse_position())
	clear_layer(LAYER.GRID)
	if cell:
		set_cell(LAYER.GRID, cell, 4, Vector2i(1,0), 0)
		
		
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		tile_map_clicked.emit(local_to_map(get_local_mouse_position()), event.position)
