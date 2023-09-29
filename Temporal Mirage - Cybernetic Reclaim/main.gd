extends Node  # Or the type of your root node if it's not a Node

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
