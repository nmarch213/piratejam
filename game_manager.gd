extends Node2D

@onready var mother_tree: MotherTree = $"../MotherTree"
@onready var game_over_screen = $GameOverScreen
@onready var game_over_screen_label = $GameOverScreen/Label
@onready var player_camera = $"../PlayerCamera"
@onready var tile_click_controller = $"../TileClickController"

var game_time: float = 0.0
var game_over: bool = false
const GAME_WIN_CODITION_SECONDS: float = 600.0


func _ready():
	game_over_screen.hide()
	mother_tree.tree_exited.connect(_on_mother_tree_exited)
	
	
func _process(delta):
	if !game_over:
		game_time += delta
	
	if game_time >= GAME_WIN_CODITION_SECONDS:
		show_game_won_screen()

	
func _on_mother_tree_exited():
	game_over = true
	end_game("Game Over\nThe mother tree died :(")
	
	
func show_game_won_screen():
	game_over = true
	end_game("You won!\nNice job on spreading for 10,000 years!")
	
	
func end_game(game_over_text: String):
	player_camera.can_move_camera = false
	player_camera.zoom = Vector2(1,1)
	game_over_screen.position = player_camera.position
	game_over_screen_label.text = game_over_text
	if is_instance_valid(tile_click_controller):
		tile_click_controller.queue_free()
	game_over_screen.show()
	
	
