extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	SunlightManager.first_purchase.connect(_on_first_purchase_by_player)

func _on_first_purchase_by_player():
	hide()
