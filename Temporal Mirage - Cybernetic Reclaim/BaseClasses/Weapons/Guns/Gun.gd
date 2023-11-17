class_name Gun
extends Weapon


var weapon_range: float = 300.0
var bullet_speed: float = 600.0
var bullet_scene = preload("res://BaseClasses/Bullets/Bullet.tscn")
var can_shoot: bool = true

# Magazine and reload variables
var magazine_size: int = 12 # Default to a medium value
var bullets_left: int = magazine_size
var max_bullets: int = magazine_size * 12
var reload_time: float = 2.0 # Default reload time
var is_reloading: bool = false


func _ready():
	damage = 10
	fire_rate = 1.0
	
	print("Gun class initialized")
	print("Gun _ready()")
	print("damage:", damage)
	print("fire_rate:", fire_rate)
	print("bullet_scene: ", bullet_scene)
	print("Node is active: ", is_inside_tree())
	print("Script is executed")
	
func use_weapon(character: Node, target_position: Vector2) -> void:
	if can_shoot and not is_reloading:
		if bullets_left > 0:
			var bullet_instance = bullet_scene.instantiate()
			if bullet_instance == null:
				printerr("Bullet instantiation failed!")
				return

			var direction = (target_position - character.global_position).normalized()
			
			# Adjust the bullet’s position
			var offset = 150
			bullet_instance.global_position = character.global_position + direction * offset
			
			print("Ammo type in Gun: ", ammo_type)
			bullet_instance.setup(direction, bullet_speed, damage, weapon_range, self.ammo_type)
			
			if bullet_instance == null:
				printerr("Bullet instance is null after setup!")
				return
				
			var character_parent = character.get_parent()
			character_parent.get_node("./../Bullets").add_child(bullet_instance) 
			
			can_shoot = false
			var timer = character.get_tree().create_timer(1.0 / fire_rate) # Create a timer
			timer.connect("timeout",  Callable(self, "_on_timer_timeout")) # Connect to a new method to reset can_shoot

			bullets_left -= 1
			if bullets_left <= 0:
				start_reloading(character)
		else:
			start_reloading(character)

func start_reloading(character: Node):
	print("Reloading")
	is_reloading = true
	can_shoot = false
	if character.is_in_group("player"):
		max_bullets -= magazine_size - bullets_left
	var reload_timer = character.get_tree().create_timer(reload_time)
	reload_timer.connect("timeout", Callable(self, "_on_reload_complete"))

func _on_reload_complete():
	bullets_left = magazine_size
	is_reloading = false
	if max_bullets > 0:
		can_shoot = true

func _on_timer_timeout():
	can_shoot = true # Reset can_shoot when the timer times out
	
	
func refill_ammo():
	max_bullets = magazine_size * 12
