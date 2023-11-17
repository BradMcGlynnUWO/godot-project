class_name DropFactory

const DropType = preload("res://BaseClasses/Drops/DropType.gd").DropType

const WeaponDrop = preload("res://BaseClasses/Drops/Scenes/WeaponDrop.tscn")
const ArmourDrop = preload("res://BaseClasses/Drops/Scenes/ArmourDrop.tscn")
const GrenadeRefillDrop = preload("res://BaseClasses/Drops/Scenes/GrenadeRefillDrop.tscn")
const GrenadeTypeDrop = preload("res://BaseClasses/Drops/Scenes/GrenadeTypeDrop.tscn")
const AmmoRefillDrop = preload("res://BaseClasses/Drops/Scripts/AmmoRefillDrop.gd")
const AmmoTypeDrop = preload("res://BaseClasses/Drops/Scripts/AmmoTypeDrop.gd")
const HealthDrop = preload("res://BaseClasses/Drops/Scenes/HealthDrop.tscn")



static func create_drop(type: String, position: Vector2) -> Node:
	var drop_instance

	match type:
		"WEAPON":
			drop_instance = WeaponDrop.instance()
		"ARMOUR":
			drop_instance = ArmourDrop.instance()
		"GRENADEREFILL":
			drop_instance = GrenadeRefillDrop.instance()
		"GRENADETYPE":
			drop_instance = GrenadeTypeDrop.instance()
		"AMMOREFILL":
			drop_instance = AmmoRefillDrop.instance()
		"AMMOTYPE":
			drop_instance = AmmoTypeDrop.instance()
		"HEALTH":
			drop_instance = HealthDrop.instance()

	drop_instance.global_position = position
	return drop_instance

