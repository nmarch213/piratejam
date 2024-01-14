extends Enemy 

@export var speed = 100

@export var tree: MotherTree
@onready var nav_agent: EnemyNavigationComponent = $EnemyNavigationComponent

func _ready() -> void:
	nav_agent.connect("velocity_computed", move)

func _physics_process(delta: float) -> void:
	var target_global_position = nav_agent.get_next_path_position()
	var dir := global_position.direction_to(target_global_position)
	var desired_velocity = dir * speed
	var steering = (desired_velocity - velocity) * delta * 4.0
	velocity = velocity + steering
	nav_agent.set_velocity(velocity)

func move(newVelocity: Vector2) -> void:
	velocity = newVelocity
	move_and_slide()

func make_path() -> void:
	nav_agent.target_position = tree.global_position

func _on_timer_timeout():
	make_path()
	$Timer.start()

