extends Node2D

@onready var mother_tree: MotherTree = $"../MotherTree"
@onready var game_over_screen = $GameOverScreen
@onready var player_camera = $"../PlayerCamera"
@onready var tile_click_controller = $"../TileClickController"


func _ready():
	game_over_screen.hide()
	mother_tree.tree_exited.connect(_on_mother_tree_exited)
	
	
func _on_mother_tree_exited():
	player_camera.can_move_camera = false
	player_camera.zoom = Vector2(1,1)
	game_over_screen.position = player_camera.position
	tile_click_controller.queue_free()
	game_over_screen.show()
