class_name BaseCharacter
extends CharacterBody2D

const ArmourType = preload("res://BaseClasses/Damage/ArmourType.gd").ArmourType
const GrenadeType = preload("res://BaseClasses/Damage/GrenadeType.gd").GrenadeType
const AmmoType = preload("res://BaseClasses/Damage/AmmoType.gd").AmmoType

var damage_multiplier = {
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
var armour_type: ArmourType = ArmourType.LIGHT


var health: int = 100
var movement_speed: float = 200.0
var weapon_slot = null # You can assign a weapon class instance here.

func _ready():
	pass

func take_damage(amount: int, ammo_type):
	var multiplier = damage_multiplier[ammo_type][armour_type]
	var actual_damage = amount * multiplier
	health -= actual_damage
	if health <= 0:
		die()


func die() -> void:
	queue_free() # Override this method to perform specific actions upon death.
	
func get_is_shield_active() -> bool:
	return false

func apply_knockback(direction: Vector2, magnitude: float):
	var start_position = global_position
	var end_position = start_position + direction * magnitude
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	#tween.tween_property(self, "global_position",start_position, 1).as_relative()
	tween.tween_property(self, "global_position",end_position, 1)
	await tween.finished
	

func swap_weapon(new_weapon_class: Script):
	if new_weapon_class:
		# Remove the current weapon
		if weapon_slot:
			weapon_slot.queue_free()
		
		# Instantiate the new weapon and assign it to the weapon slot
		var new_weapon_instance = new_weapon_class.new()
		add_child(new_weapon_instance)
		weapon_slot = new_weapon_instance


