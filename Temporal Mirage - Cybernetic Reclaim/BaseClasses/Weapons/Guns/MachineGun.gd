class_name MachineGun
extends Gun

func _ready():
	# Set up the properties of the gun
	damage = 200 # Example damage value
	fire_rate = 10.0 # High fire rate, adjust as needed
	weapon_range = 700.0 # Example range value
	bullet_speed = 10000.0 # Example bullet speed value
	print("MachineGun _ready()")
	print("damage:", damage)
	print("fire_rate:", fire_rate)
