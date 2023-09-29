class_name Gun
extends Node

var damage: int = 10 # Default damage value
var fire_rate: float = 1.0 # Default fire rate, shots per second
var weapon_range: float = 300.0 # Default range value
var bullet_speed: float = 600.0 # Default bullet speed value
var bullet_scene = preload("res://BaseClasses/Bullets/Bullet.tscn") # Preload the bullet scene
var can_shoot: bool = true


func _ready():
	print("Gun class initialized")
	print("bullet_scene: ", bullet_scene)
	print("Node is active: ", is_inside_tree())
	print("Script is executed")
	
func use_weapon(character: Node, target_position: Vector2) -> void:
	if can_shoot:
		print(bullet_scene)
		var bullet_instance = bullet_scene.instantiate()
		if bullet_instance == null:
			printerr("Bullet instantiation failed!")
			return

		var direction = (target_position - character.global_position).normalized()
		
		# Adjust the bullet’s position
		var offset = 150
		bullet_instance.global_position = character.global_position + direction * offset
		
		# Add collision exception
		#bullet_instance.add_collision_exception_with(character)
		bullet_instance.setup(direction, bullet_speed, damage, weapon_range)
		if bullet_instance == null:
			printerr("Bullet instance is null after setup!")
			return

		character.get_tree().get_root().get_node("main/Bullets").add_child(bullet_instance)

		can_shoot = false
		var timer = character.get_tree().create_timer(1.0 / fire_rate) # Create a timer
		timer.connect("timeout",  Callable(self, "_on_timer_timeout")) # Connect to a new method to reset can_shoot

		print("Character Position: ", character.global_position)
		print("Target Position: ", target_position)
		print("Bullet Direction: ", direction)
func _on_timer_timeout():
	can_shoot = true # Reset can_shoot when the timer times out
	
