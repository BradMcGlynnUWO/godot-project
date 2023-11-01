class_name Weapon
extends Node

var damage: int = 10
var fire_rate: float = 1.0 # shots/attacks per second
var range: float = 100.0

const AmmoType = preload("res://BaseClasses/Damage/AmmoType.gd").AmmoType
var ammo_type: AmmoType


func use_weapon(character: Node, target_position: Vector2) -> void:
	# Implement the logic to use the weapon.
	# For example, reduce the target's health by the weapon's damage.
	pass
