extends Bullet
class_name BeehiveBullet

var timer: Timer
@export var damage_ticks: int = 5
@export var ticks_per_second: int = 1
@export var aoe_radius: float = 100.0

var enemies_in_aoe = []
var aoe_area: Area2D

func _ready():
	speed = 500
	self.body_entered.connect(_on_bullet_body_entered)
	_setup_timer()

func _spawn_aoe_area(body: Enemy):
	aoe_area = Area2D.new()
	var collision = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = aoe_radius
	collision.shape = shape
	aoe_area.body_entered.connect(_on_aoe_area_entered)
	aoe_area.body_exited.connect(_on_aoe_area_exited)
	aoe_area.monitoring = true
	aoe_area.add_child(collision)
	aoe_area.add_child(create_visual_representation())
	get_tree().root.call_deferred("add_child", aoe_area)
	aoe_area.global_position = body.global_position


func _on_aoe_area_entered(body):
	print("Body entered")
	if body is Enemy:
		if body not in enemies_in_aoe:
			enemies_in_aoe.append(body)

func _on_aoe_area_exited(body):
	if body is Enemy:
		if body in enemies_in_aoe:
			enemies_in_aoe.erase(body)

func _setup_timer():
	timer = Timer.new()
	timer.set_wait_time(ticks_per_second)
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout():
	print("Timer timeout")
	print(enemies_in_aoe)
	if damage_ticks > 0:
		damage_ticks -= 1
		for enemy in enemies_in_aoe:
			enemy.healthComponent.take_damage(bullet_damage)
		timer.start()
	else:
		queue_free()

func create_visual_representation() -> Sprite2D:
	var sprite = Sprite2D.new()
	sprite.texture = create_colored_texture(Color(1, 0, 0, 0.5), Vector2(100, 100))  # Red color with some transparency, 100x100 size
	return sprite

func create_colored_texture(color: Color, size: Vector2) -> ImageTexture:
	var image = Image.create(int(size.x), int(size.y), false, Image.FORMAT_RGBA8)
	image.fill(color)

	var texture = ImageTexture.create_from_image(image)
	return texture

func _on_bullet_body_entered(body: Enemy):
	call_deferred("_spawn_aoe_area", body)
	timer.start()
