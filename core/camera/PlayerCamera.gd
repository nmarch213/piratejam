extends Camera2D
@onready var tile_map: TileMap = $"../TileMap"

var dragging = false
var drag_start
var screen_start
var can_move_camera = true

func _ready():
	var map_limits: Rect2i = tile_map.get_used_rect()
	var map_cellsize = tile_map.rendering_quadrant_size
	limit_left = (map_limits.position.x * map_cellsize) + 200
	limit_right = limit_left + 2000
	limit_top = map_limits.position.y * map_cellsize
	limit_bottom = limit_top + 1500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if !can_move_camera:
		return
	if event.is_action('right click'):
		if event.is_pressed():
			dragging = true
			drag_start = event.position
			screen_start = position
		else:
			dragging = false
			drag_start = null
			screen_start = null	
	elif event is InputEventMouseMotion and dragging:
		position = zoom * (drag_start - event.position) + screen_start
	elif event.is_action_pressed('zoom in'):
		zoom.x += 0.25
		zoom.y += 0.25
	elif event.is_action_pressed('zoom out'):
		zoom.x -= 0.25
		zoom.y -= 0.25
	
		
