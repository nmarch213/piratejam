extends Enemy 

@export var speed = 100

@export var tree: MotherTree
@onready var nav_agent: EnemyNavigationComponent = $EnemyNavigationComponent

func _ready() -> void:
	nav_agent.connect("velocity_computed", move)

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	nav_agent.set_velocity(velocity)

func move(newVelocity: Vector2) -> void:
	velocity = newVelocity
	move_and_slide()

func make_path() -> void:
	nav_agent.target_position = tree.global_position

func _on_timer_timeout():
	make_path()
	$Timer.start()

