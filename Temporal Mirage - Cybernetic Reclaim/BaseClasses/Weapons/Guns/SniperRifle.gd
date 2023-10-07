class_name SniperRifle
extends Gun

func _ready():
	damage = 80 # High damage
	fire_rate = 1 # Low fire rate
	weapon_range = 1000.0 # Long range
	bullet_speed = 700.0 # Fast bullet speed
	# Magazine and reload variables
	magazine_size = 6 # Default to a medium value
	bullets_left = magazine_size
	reload_time = 8.0 # Default reload time
