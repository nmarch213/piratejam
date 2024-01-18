extends Bullet 
class_name ThornBullet

func _ready():
	self.body_entered.connect(_on_bullet_body_entered)
