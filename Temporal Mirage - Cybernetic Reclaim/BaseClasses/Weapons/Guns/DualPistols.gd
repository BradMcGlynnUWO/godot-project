class_name DualPistols
extends Gun

# Dual Pistols may have a higher fire rate and different magazine size
var dual_fire_rate: float = 2.0
var dual_magazine_size: int = 24 # Assuming each pistol has a magazine of 12

func _ready():
	damage = 8 # Slightly less damage per bullet, since there are two pistols
	fire_rate = dual_fire_rate
	magazine_size = dual_magazine_size
	bullets_left = magazine_size
	print("Dual Pistols class initialized")

func use_weapon(character: Node, target_position: Vector2) -> void:
	if can_shoot and not is_reloading:
		if bullets_left > 1: # Need at least 2 bullets to shoot
			# Fire two bullets
			for i in range(2):
				var bullet_instance = bullet_scene.instance()
				if bullet_instance == null:
					printerr("Bullet instantiation failed!")
					return

				var direction = (target_position - character.global_position).normalized()
				# Adjust the bullet’s position slightly for each pistol
				var offset = Vector2(150, 0).rotated(i * PI / 30) # Slight angle difference for the second bullet
				bullet_instance.global_position = character.global_position + direction * offset.length() + offset

				print("Ammo type in Dual Pistols: ", ammo_type)
				bullet_instance.setup(direction, bullet_speed, damage, weapon_range, self.ammo_type)

				var character_parent = character.get_parent()
				character_parent.get_node("./../Bullets").add_child(bullet_instance)

			can_shoot = false
			bullets_left -= 2 # Subtract two bullets
			var timer = character.get_tree().create_timer(1.0 / fire_rate)
			timer.connect("timeout", Callable(self, "_on_timer_timeout"))

			if bullets_left <= 1: # Check if there's only one bullet left, which can't be used by Dual Pistols
				start_reloading(character)
		else:
			start_reloading(character)
	else:
		if not can_shoot:
			print("Cannot shoot: Waiting for fire rate cooldown.")
		if is_reloading:
			print("Cannot shoot: Currently reloading.")
