class_name GrenadeLauncher
extends Gun

var grenade_scene = preload("res://BaseClasses/Grenades/Grenade.tscn")

func _ready():
	bullet_scene = grenade_scene # Override the bullet scene with the grenade scene
	# Set up the properties of the GrenadeLauncher
	damage = 5 # Low damage for launching grenade, but explosion is high damage
	fire_rate = 1.0 # Low fire rate, adjust as needed
	weapon_range = 300.0 
	bullet_speed = 100.0 
	# Magazine and reload variables
	magazine_size = 6 
	bullets_left = magazine_size
	reload_time = 2.0 
	ammo_type = AmmoType.EXPLOSIVE

func use_weapon(character: Node, target_position: Vector2) -> void:
	if can_shoot and not is_reloading:
		if bullets_left > 0:
			var direction = (target_position - character.global_position).normalized()
			
			var grenade_instance = grenade_scene.instantiate()
			if grenade_instance == null:
				printerr("Grenade instantiation failed!")
				return

			grenade_instance.setup(direction, bullet_speed, damage, weapon_range, ammo_type)
			
			# Adjust the bullet’s position
			var offset = 150
			grenade_instance.global_position = character.global_position + direction * offset

			var character_parent = character.get_parent()
			#if character.is_in_group("player"):
				
			character_parent.get_node("./../Grenades").add_child(grenade_instance)
			#else:
				#character.get_node("./Grenades").add_child(grenade_instance)
			
			
			can_shoot = false
			var timer = character.get_tree().create_timer(1.0 / fire_rate) # Create a timer
			timer.connect("timeout",  Callable(self, "_on_timer_timeout")) # Connect to a new method to reset can_shoot

			print("Character Position: ", character.global_position)
			print("Target Position: ", target_position)
			print("Bullet Direction: ", direction)
			bullets_left -= 1
			if bullets_left <= 0:
				start_reloading(character)
		else:
			start_reloading(character)
