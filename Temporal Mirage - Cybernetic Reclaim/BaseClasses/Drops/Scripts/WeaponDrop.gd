extends Area2D

# Preload weapon classes
""" # weapons to be added
const Pistol = preload("res://BaseClasses/Weapons/Pistol.gd")
const Shotgun = preload("res://BaseClasses/Weapons/Shotgun.gd")
const Rifle = preload("res://BaseClasses/Weapons/Rifle.gd")
"""
const GrenadeLauncher = preload("res://BaseClasses/Weapons/Guns/GrenadeLauncher.gd")
const MachineGun = preload("res://BaseClasses/Weapons/Guns/MachineGun.gd")
const SniperRifle = preload("res://BaseClasses/Weapons/Guns/SniperRifle.gd")
# ... Add other weapon classes as needed

# List of weapon classes
const WeaponClassesArray = [
	#Pistol,
	#Shotgun,
	#Rifle,
	GrenadeLauncher,
	MachineGun,
	SniperRifle
	# ... Add other weapon classes as needed
]

# The weapon class that this drop represents
var weapon_class: Script = null

@onready var weapon_label = $Label

func _ready():
	# Randomize weapon_class if you want
	weapon_class = WeaponClassesArray[randi() % WeaponClassesArray.size()]
	
	# Update the label to reflect the weapon type
	weapon_label.text = weapon_class_to_string(weapon_class)

func _on_body_entered(body: Node):
	if body is BaseCharacter and body.is_in_group("player"):
		body.swap_weapon(weapon_class)
		body.update_ammo_display()
		queue_free()  # Remove the weapon drop from the scene

func weapon_class_to_string(weapon_script: Script) -> String:
	# This function returns a string representation of the weapon class
	# You can customize this function based on your needs
	#if weapon_script == Pistol:
	#	return "Pistol"
	#elif weapon_script == Shotgun:
	#	return "Shotgun"
	#elif weapon_script == Rifle:
	#	return "Rifle"
	if weapon_script == GrenadeLauncher:
		return "GrenadeLauncher"
	elif weapon_script == MachineGun:
		return "MachineGun"
	elif weapon_script == SniperRifle:
		return "SniperRifle"
	# ... Add other weapon classes as needed
	else:
		return "Unknown Weapon"
