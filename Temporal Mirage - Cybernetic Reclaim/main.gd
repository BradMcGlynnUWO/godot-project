extends Node  # Or the type of your root node if it's not a Node

func _on_button_pressed():
	get_tree().change_scene_to_file("res://areas/urban-streets/city_home.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()