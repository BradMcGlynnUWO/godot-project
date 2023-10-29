class_name MachineGun
extends Gun

func _ready():
	# Set up the properties of the gun
	damage = 20 # Example damage value
	fire_rate = 10.0 # High fire rate, adjust as needed
	weapon_range = 300.0 # Example range value
	bullet_speed = 1000.0 # Example bullet speed value
	# Magazine and reload variables
	magazine_size = 30 # Default to a medium value
	bullets_left = magazine_size
	max_bullets = magazine_size * 10
	reload_time = 2.0 # Default reload time
	
