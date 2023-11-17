extends Node

const AmmoType = preload("res://BaseClasses/Damage/AmmoType.gd").AmmoType
const ArmourType = preload("res://BaseClasses/Damage/ArmourType.gd").ArmourType


@onready var damage_multiplier = {
	AmmoType.STANDARD: {
		ArmourType.LIGHT: 1.0,
		ArmourType.MEDIUM: 0.8,
		ArmourType.HEAVY: 0.6,
		ArmourType.HAZMAT: 1.0,
		ArmourType.STEALTH: 0.9,
		ArmourType.TEMPORAL: 1.0,
		ArmourType.RIOT: 0.7,
		ArmourType.NANOFIBER: 0.85,
		ArmourType.ENERGY_SHIELD: 1.2
	},
	AmmoType.ACIDIC: {
		ArmourType.LIGHT: 1.2,
		ArmourType.MEDIUM: 1.0,
		ArmourType.HEAVY: 0.5,
		ArmourType.HAZMAT: 0.4,  # Strong protection against acidic damage
		ArmourType.STEALTH: 1.1,
		ArmourType.TEMPORAL: 1.2,
		ArmourType.RIOT: 0.9,
		ArmourType.NANOFIBER: 1.0,
		ArmourType.ENERGY_SHIELD: 1.3
	},
	AmmoType.ELECTRIC: {
		ArmourType.LIGHT: 0.8,
		ArmourType.MEDIUM: 1.5,
		ArmourType.HEAVY: 0.7,
		ArmourType.HAZMAT: 1.1,
		ArmourType.STEALTH: 0.7,
		ArmourType.TEMPORAL: 0.9,
		ArmourType.RIOT: 0.8,
		ArmourType.NANOFIBER: 0.9,
		ArmourType.ENERGY_SHIELD: 0.5  # Vulnerable to electric attacks
	},
	AmmoType.FIRE: {
		ArmourType.LIGHT: 1.4,
		ArmourType.MEDIUM: 1.1,
		ArmourType.HEAVY: 0.9,
		ArmourType.HAZMAT: 0.6,  # Some protection against fire
		ArmourType.STEALTH: 1.3,
		ArmourType.TEMPORAL: 1.2,
		ArmourType.RIOT: 1.0,
		ArmourType.NANOFIBER: 1.2,
		ArmourType.ENERGY_SHIELD: 1.4
	},
	AmmoType.EXPLOSIVE: {
		ArmourType.LIGHT: 1.3,
		ArmourType.MEDIUM: 1.1,
		ArmourType.HEAVY: 0.8,
		ArmourType.HAZMAT: 1.2,
		ArmourType.STEALTH: 1.4,
		ArmourType.TEMPORAL: 1.3,
		ArmourType.RIOT: 0.5,  # Strong protection against explosives
		ArmourType.NANOFIBER: 1.0,
		ArmourType.ENERGY_SHIELD: 1.5
	},
	AmmoType.ENERGY: {
		ArmourType.LIGHT: 1.2,
		ArmourType.MEDIUM: 1.0,
		ArmourType.HEAVY: 0.9,
		ArmourType.HAZMAT: 1.1,
		ArmourType.STEALTH: 0.8,
		ArmourType.TEMPORAL: 0.7,
		ArmourType.RIOT: 1.0,
		ArmourType.NANOFIBER: 0.9,
		ArmourType.ENERGY_SHIELD: 0.3  # Strong protection against energy attacks
	}, 
	AmmoType.PIERCING: {
		ArmourType.LIGHT: 1.2,
		ArmourType.MEDIUM: 1.0,
		ArmourType.HEAVY: 0.8,
		ArmourType.HAZMAT: 1.1,
		ArmourType.STEALTH: 1.3,
		ArmourType.TEMPORAL: 1.0,
		ArmourType.RIOT: 0.9,
		ArmourType.NANOFIBER: 0.7,
		ArmourType.ENERGY_SHIELD: 1.4
	},
	AmmoType.BLUDGEONING: {
		ArmourType.LIGHT: 1.0,
		ArmourType.MEDIUM: 0.9,
		ArmourType.HEAVY: 0.7,
		ArmourType.HAZMAT: 1.0,
		ArmourType.STEALTH: 1.1,
		ArmourType.TEMPORAL: 1.2,
		ArmourType.RIOT: 0.8,
		ArmourType.NANOFIBER: 0.9,
		ArmourType.ENERGY_SHIELD: 1.3
	},
	AmmoType.SLASHING: {
		ArmourType.LIGHT: 1.3,
		ArmourType.MEDIUM: 1.1,
		ArmourType.HEAVY: 0.9,
		ArmourType.HAZMAT: 1.2,
		ArmourType.STEALTH: 1.0,
		ArmourType.TEMPORAL: 1.1,
		ArmourType.RIOT: 1.0,
		ArmourType.NANOFIBER: 0.8,
		ArmourType.ENERGY_SHIELD: 1.2
	}
}
