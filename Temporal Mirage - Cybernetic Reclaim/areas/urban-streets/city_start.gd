extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()