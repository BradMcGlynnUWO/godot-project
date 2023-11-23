class_name DropFactory

const DropType = preload("res://BaseClasses/Drops/DropType.gd").DropType

const WeaponDrop = preload("res://BaseClasses/Drops/Scenes/WeaponDrop.tscn")
const ArmourDrop = preload("res://BaseClasses/Drops/Scenes/ArmourDrop.tscn")
const GrenadeRefillDrop = preload("res://BaseClasses/Drops/Scenes/GrenadeRefillDrop.tscn")
const GrenadeTypeDrop = preload("res://BaseClasses/Drops/Scenes/GrenadeTypeDrop.tscn")
const AmmoRefillDrop = preload("res://BaseClasses/Drops/Scenes/AmmoRefillDrop.tscn")
const AmmoTypeDrop = preload("res://BaseClasses/Drops/Scenes/AmmoTypeDrop.tscn")
const HealthDrop = preload("res://BaseClasses/Drops/Scenes/HealthDrop.tscn")

static func create_drop(type: DropType, position: Vector2) -> Node:
	var drop_instance

	match type:
		DropType.WEAPON:
			drop_instance = WeaponDrop.instantiate()
		DropType.ARMOUR:
			drop_instance = ArmourDrop.instantiate()
		DropType.GRENADEREFILL:
			drop_instance = GrenadeRefillDrop.instantiate()
		DropType.GRENADETYPE:
			drop_instance = GrenadeTypeDrop.instantiate()
		DropType.AMMOREFILL:
			drop_instance = AmmoRefillDrop.instantiate()
		DropType.AMMOTYPE:
			drop_instance = AmmoTypeDrop.instantiate()
		DropType.HEALTH:
			drop_instance = HealthDrop.instantiate()

	drop_instance.global_position = position
	return drop_instance

