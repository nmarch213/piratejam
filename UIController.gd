extends Node2D

var latest_cell_clicked: Vector2i = Vector2i(-1, -1)


func _on_tile_map_tile_map_clicked(cell_clicked_position: Vector2i, event_position: Vector2):
	var buy_menu: PopupMenu = get_node("BuyMenu")

	buy_menu.position = event_position
	buy_menu.show()
	latest_cell_clicked = cell_clicked_position	
