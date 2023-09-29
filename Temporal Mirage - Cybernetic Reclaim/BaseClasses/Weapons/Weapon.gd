class_name Weapon
extends Node

var damage: int = 10
var fire_rate: float = 1.0 # shots/attacks per second
var range: float = 100.0

func use_weapon(target: Vector2) -> void:
	# Implement the logic to use the weapon.
	# For example, reduce the target's health by the weapon's damage.
	pass
