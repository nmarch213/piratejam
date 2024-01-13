extends Enemy 

const speed = 20

@export var tree: MotherTree
@onready var nav_agent: EnemyNavigationComponent = $EnemyNavigationComponent

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()

func make_path() -> void:
	nav_agent.target_position = tree.global_position

func _on_timer_timeout():
	make_path()
	$Timer.start()

