class_name EnemyFactory

const EnemyType = preload("res://BaseClasses/Characters/Enemy/EnemyTypes.gd").EnemyType
const ArmourType = preload("res://BaseClasses/Damage/ArmourType.gd").ArmourType
const MovementStrategy = preload("res://BaseClasses/Characters/Enemy/Movement/MovementStrategy.gd")
const AggressiveMovement = preload("res://BaseClasses/Characters/Enemy/Movement/AggressiveMovement.gd")
const DefensiveMovement = preload("res://BaseClasses/Characters/Enemy/Movement/DefensiveMovement.gd")

const DualPistols = preload("res://BaseClasses/Weapons/Guns/DualPistols.gd")
const GrenadeLauncher = preload("res://BaseClasses/Weapons/Guns/GrenadeLauncher.gd")
const MachineGun = preload("res://BaseClasses/Weapons/Guns/MachineGun.gd")
const SniperRifle = preload("res://BaseClasses/Weapons/Guns/SniperRifle.gd")



static var EnemyConfig = {
	EnemyType.GRENADER: {
		"health": 100,
		"movement_speed": 70.0,
		"weapon_class": GrenadeLauncher,
		"detection_radius": 600.0,
		"armour_type": ArmourType.MEDIUM,
		"movement_strategy": AggressiveMovement
		# ... other properties
	},
	EnemyType.BRUTE: {
		"health": 100,
		"movement_speed": 50.0,
		"melee_attack_range": 50.0,
		"melee_damage": 50,
		"detection_radius": 300.0,
		"armour_type": ArmourType.HEAVY, 
		"movement_strategy": AggressiveMovement
		# ... other properties
	},
	EnemyType.SNIPER: {
		"health": 100,
		"movement_speed": 150.0,
		"weapon_class": SniperRifle,
		"detection_radius": 1000.0,
		"armour_type": ArmourType.MEDIUM,
		"movement_strategy": DefensiveMovement
		# ... other properties
	}
	# ... add configurations for other enemy types
}




static func create_enemy(type: EnemyType, position: Vector2) -> Node:
	var enemy_scene = preload("res://BaseClasses/Characters/Enemy/Enemy.tscn") # Adjust the path as necessary
	var enemy_instance = enemy_scene.instantiate() as Enemy
	var config = EnemyConfig[type]

	# Initialize the enemy with the config properties
	enemy_instance.initialize(config)

	# Set the position of the enemy
	enemy_instance.global_position = position

	return enemy_instance
