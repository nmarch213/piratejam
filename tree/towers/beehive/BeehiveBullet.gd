extends Bullet
class_name BeehiveBullet

var timer: Timer
var aoe_img = preload("res://tree/towers/beehive/beehiveBeehive.png")
@export var total_ticks_of_dmg: int = 5
@export var pulse: float = .4
@export var aoe_radius: float = 100.0
@export var aoe_dmg: int = 1

var enemies_in_aoe = []
var reached_target = false 
var target_position: Vector2
var timer_started = false

func _ready():
	speed = 500
	bullet_damage = 5
	timer = Timer.new()
	timer.set_wait_time(pulse)
	timer.timeout.connect(_on_aoe_timer_timeout)
	add_child(timer)

	self.body_entered.connect(_on_aoe_area_entered)
	self.body_exited.connect(_on_aoe_area_exited)

func _physics_process(delta):
	if not is_instance_valid(target) && !timer_started:
		queue_free()
		return
	if _has_reached_target():
		if !timer_started:
			timer_started = true
			timer.start()
		return
	if !target_position:
		target_position = target.global_position
	if target_position:
		var direction = (target_position - global_position).normalized()
		global_position += direction * speed * delta
	else:
			global_position += Vector2(0, -speed * delta)
		
func _has_reached_target() -> bool:
	return global_position.distance_to(target_position) < 15

func _on_aoe_timer_timeout():
	if total_ticks_of_dmg == 0:
		queue_free()

	total_ticks_of_dmg -= 1
	for enemy in enemies_in_aoe:
		enemy.healthComponent.take_damage(aoe_dmg)

func _on_aoe_area_entered(body):
	if body is Enemy:
		if body not in enemies_in_aoe:
			enemies_in_aoe.append(body)

func _on_aoe_area_exited(body):
	if body is Enemy:
		if body in enemies_in_aoe:
			enemies_in_aoe.erase(body)

