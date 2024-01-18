extends Node2D

@onready var mother_tree: MotherTree = $"../MotherTree"
@onready var game_over_screen = $GameOverScreen
@onready var player_camera = $"../PlayerCamera"


func _ready():
	game_over_screen.hide()
	mother_tree.tree_exited.connect(_on_mother_tree_exited)
	print("in")
	
	
func _on_mother_tree_exited():
	player_camera.can_move_camera = false
	player_camera.zoom = Vector2(1,1)
	game_over_screen.position = player_camera.position
	game_over_screen.show()
