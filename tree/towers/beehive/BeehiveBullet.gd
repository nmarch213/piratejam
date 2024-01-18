extends Bullet
class_name BeehiveBullet

func _ready():
	self.body_entered.connect(_on_bullet_body_entered)
