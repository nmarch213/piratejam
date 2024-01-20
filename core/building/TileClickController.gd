extends Node2D

var latest_cell_clicked: Vector2i = Vector2i(-1, -1)
@onready var buy_menu: PopupMenu = get_node("BuyMenu")
@onready var tile_map: TileMap = $"../TileMap"
var mother_tree_positions = []
var tower_positions = []

func _ready():
	tile_map.tile_map_clicked.connect(_on_tile_map_tile_map_clicked)
	buy_menu.hide()
	var mother_tree_coords = tile_map.local_to_map($"../MotherTree".position)
	mother_tree_positions.append(Vector2(mother_tree_coords))
	mother_tree_positions.append_array(tile_map.get_surrounding_cells(mother_tree_coords).map(to_vector2))

func _on_tile_map_tile_map_clicked(cell_clicked_position: Vector2i, event_position: Vector2):
	tower_positions = tile_map.get_used_cells(tile_map.LAYER.TOWERS).map(to_vector2)
	if mother_tree_positions.has(cell_clicked_position):
		pass #TODO: mother tree upgrades?
	elif tower_positions.has(cell_clicked_position):
		pass #TODO: upgrade menu / select the tower
	elif tile_map.get_cell_atlas_coords(tile_map.LAYER.BASE, cell_clicked_position) == tile_map.GRASS_ATLAS_COORDS and !is_mother_tree_position(cell_clicked_position):
		buy_menu.position = event_position
		buy_menu.show()
		latest_cell_clicked = cell_clicked_position	
		
func within_two_spaces_of_existing_tower(cell_clicked_position):
	var all_friendly_positions = []
	all_friendly_positions.append_array(mother_tree_positions)
	all_friendly_positions.append_array(tower_positions)
	for tower in all_friendly_positions:
		if tower.distance_to(Vector2(cell_clicked_position)) <= 2:
			return true
	
func to_vector2(cell: Vector2i):
	return Vector2(cell)
	
	
func is_mother_tree_position(cell_clicked_position: Vector2i) -> bool:
	for mother_tree_position in mother_tree_positions:
		if mother_tree_position == to_vector2(cell_clicked_position):
			return true
	
	return false
	
	
