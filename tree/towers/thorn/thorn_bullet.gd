extends Bullet 
class_name ThornBullet

func _ready():
	self.body_entered.connect(_on_bullet_body_entered)
	# Modify this value to change the power of thorn attacks. This value is later used by attack 
	# component. Direct updates to attack component are not functioning
	self.bullet_damage = 4
